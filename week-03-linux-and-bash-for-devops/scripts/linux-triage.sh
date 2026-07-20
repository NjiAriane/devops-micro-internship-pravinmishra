#!/bin/bash
#
# linux-triage.sh — Read-only Linux & Nginx health triage
#
# Author : NJI ARIANE RUTH
# Purpose: Gather health evidence for the EpicReads Nginx server.
#          This script is READ-ONLY. It never restarts, stops, edits,
#          or otherwise modifies the system.
#
# Exit codes:
#   0 = HEALTHY  (all checks passed)
#   1 = WARN     (no failures, but at least one warning)
#   2 = FAIL     (at least one check failed)

# ----------------------------------------------------------------------
# Configuration
# ----------------------------------------------------------------------
FULL_NAME="NJI ARIANE RUTH"

# Where evidence reports are saved
REPORTS_DIR="reports"

# Target service / endpoint
SERVICE="nginx"
HTTP_PORT="80"
URL="http://localhost"

# Warning thresholds (percentages)
MEM_WARN_THRESHOLD=80    # warn if used memory >= 80%
DISK_WARN_THRESHOLD=80   # warn if root filesystem usage >= 80%

# The checks we run, in order
checks=(
  "Nginx Service"
  "HTTP Port"
  "Website Response"
  "System Resources"
  "Application Health"
)

# ----------------------------------------------------------------------
# State (populated as checks run)
# ----------------------------------------------------------------------
declare -A STATUS   # check name -> HEALTHY | WARN | FAIL
declare -A DETAIL   # check name -> human-readable evidence line

# ----------------------------------------------------------------------
# Check functions — each sets STATUS[...] and DETAIL[...]
# ----------------------------------------------------------------------

# 1. Is the Nginx service active?
check_nginx_service() {
  local name="Nginx Service"
  local state
  state=$(systemctl is-active "$SERVICE" 2>/dev/null)

  if [ "$state" = "active" ]; then
    STATUS[$name]="HEALTHY"
    DETAIL[$name]="systemctl is-active $SERVICE => $state"
  else
    STATUS[$name]="FAIL"
    DETAIL[$name]="systemctl is-active $SERVICE => ${state:-unknown}"
  fi
}

# 2. Is something listening on the HTTP port?
check_http_port() {
  local name="HTTP Port"
  local listening
  listening=$(ss -ltn 2>/dev/null | grep ":$HTTP_PORT ")

  if [ -n "$listening" ]; then
    STATUS[$name]="HEALTHY"
    DETAIL[$name]="Port $HTTP_PORT listening: $(echo "$listening" | awk '{print $4}' | tr '\n' ' ')"
  else
    STATUS[$name]="FAIL"
    DETAIL[$name]="No process listening on TCP port $HTTP_PORT"
  fi
}

# 3. Does the website respond with a healthy HTTP status?
check_website_response() {
  local name="Website Response"
  local code
  code=$(curl -s -o /dev/null -w '%{http_code}' -I --max-time 5 "$URL" 2>/dev/null)

  if [ "$code" = "200" ]; then
    STATUS[$name]="HEALTHY"
    DETAIL[$name]="curl -I $URL => HTTP $code"
  elif [ "$code" -ge 200 ] 2>/dev/null && [ "$code" -lt 400 ] 2>/dev/null; then
    STATUS[$name]="WARN"
    DETAIL[$name]="curl -I $URL => HTTP $code (non-200 but reachable)"
  else
    STATUS[$name]="FAIL"
    DETAIL[$name]="curl -I $URL => HTTP ${code:-000} (no successful response)"
  fi
}

# 4. Are memory and disk usage within thresholds?
check_system_resources() {
  local name="System Resources"
  local mem_used disk_used load

  # Memory used percentage from free
  mem_used=$(free | awk '/^Mem:/ {printf "%.0f", ($3/$2)*100}')

  # Root filesystem used percentage from df (strip the % sign)
  disk_used=$(df / | awk 'NR==2 {gsub("%","",$5); print $5}')

  # Load info from uptime (for context in the report)
  load=$(uptime | sed 's/.*load average: //')

  if [ "$mem_used" -ge "$MEM_WARN_THRESHOLD" ] || [ "$disk_used" -ge "$DISK_WARN_THRESHOLD" ]; then
    STATUS[$name]="WARN"
  else
    STATUS[$name]="HEALTHY"
  fi
  DETAIL[$name]="Memory used ${mem_used}% (warn >= ${MEM_WARN_THRESHOLD}%), Disk / used ${disk_used}% (warn >= ${DISK_WARN_THRESHOLD}%), load average: ${load}"
}

# 5. Overall application health (service + port + response together).
check_application_health() {
  local name="Application Health"
  local svc="${STATUS[Nginx Service]}"
  local port="${STATUS[HTTP Port]}"
  local web="${STATUS[Website Response]}"

  if [ "$svc" = "HEALTHY" ] && [ "$port" = "HEALTHY" ] && [ "$web" = "HEALTHY" ]; then
    STATUS[$name]="HEALTHY"
    DETAIL[$name]="Service active, port $HTTP_PORT open, and $URL serving traffic"
  elif [ "$svc" = "FAIL" ] || [ "$port" = "FAIL" ] || [ "$web" = "FAIL" ]; then
    STATUS[$name]="FAIL"
    DETAIL[$name]="Application not fully serving traffic (service=$svc, port=$port, response=$web)"
  else
    STATUS[$name]="WARN"
    DETAIL[$name]="Application degraded (service=$svc, port=$port, response=$web)"
  fi
}

# Map a check name to its function
run_check() {
  case "$1" in
    "Nginx Service")      check_nginx_service ;;
    "HTTP Port")          check_http_port ;;
    "Website Response")   check_website_response ;;
    "System Resources")   check_system_resources ;;
    "Application Health") check_application_health ;;
  esac
}

# ----------------------------------------------------------------------
# Main
# ----------------------------------------------------------------------

# Create the reports directory if it does not exist
if [ ! -d "$REPORTS_DIR" ]; then
  mkdir -p "$REPORTS_DIR"
fi

REPORT_FILE="$REPORTS_DIR/triage-report.txt"

# Run every check in array order
for check in "${checks[@]}"; do
  run_check "$check"
done

# Tally results and print per-check status
fail_count=0
warn_count=0

print_line() {
  printf "  [%-7s] %-20s %s\n" "$1" "$2" "$3"
}

# Build the report body once, then print it and save it.
{
  echo "======================================================"
  echo " Linux Triage Report"
  echo "======================================================"
  echo " Full Name : $FULL_NAME"
  echo " Host      : $(uname -n)"
  echo " Generated : $(date '+%Y-%m-%d %H:%M:%S')"
  echo " Mode      : READ-ONLY (no system changes made)"
  echo "------------------------------------------------------"
  for check in "${checks[@]}"; do
    print_line "${STATUS[$check]}" "$check" "${DETAIL[$check]}"
  done
  echo "------------------------------------------------------"
} | tee "$REPORT_FILE"

# Count failures and warnings (after printing, so the loop stays clean)
for check in "${checks[@]}"; do
  case "${STATUS[$check]}" in
    FAIL) fail_count=$((fail_count + 1)) ;;
    WARN) warn_count=$((warn_count + 1)) ;;
  esac
done

# Determine overall status and exit code
if [ "$fail_count" -gt 0 ]; then
  overall="FAIL"
  exit_code=2
elif [ "$warn_count" -gt 0 ]; then
  overall="WARN"
  exit_code=1
else
  overall="HEALTHY"
  exit_code=0
fi

# Final summary (printed and appended to the report)
{
  echo " SUMMARY"
  echo "   Checks : ${#checks[@]}"
  echo "   Failed : $fail_count"
  echo "   Warned : $warn_count"
  echo "   Overall Status: $overall"
  echo "   Report saved to: $REPORT_FILE"
  echo "======================================================"
} | tee -a "$REPORT_FILE"

exit "$exit_code"
