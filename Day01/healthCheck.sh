#!/bin/bash
# 
# Author: Harsh Soni
# Date: 28-01-2025 | Modification Date: 28-01-2025
# Description:  This script is a menu-driven script that performs essential system health checks. This tool should allow users to select from the following options:
#               - Check Disk Usage
#               - Monitor Running Services
#               - Assess Memory Usage
#               - Evaluate CPU Usage
#               - Send a Comprehensive Report via Email Every Four Hours
#

# Enable debugging if DEBUG is set to true
DEBUG=true
if [ "$DEBUG" = true ]; then
    set -x
fi

EMAIL="harshsoni6011@gmail.com"

REPORT_FILE="/tmp/system_health_report.txt"
# REPORT_FILE="/media/harshs/962E1F992E1F720B/1.Professional/1. Learning/CloudComputing/Learnings_Devops/Shell_Scripting/DailyChallenge/Day01/system_health_report.txt"

check_disk_usage() {
    echo "=== DISK USAGE ===" > $REPORT_FILE
    df -h >> $REPORT_FILE
    cat $REPORT_FILE
}

monitor_services() {
    echo "=== RUNNING SERVICES ===" > $REPORT_FILE
    systemctl list-units --type=service --state=running >> $REPORT_FILE
    cat $REPORT_FILE
}

check_memory_usage() {
    echo "=== MEMORY USAGE ===" > $REPORT_FILE
    free -h >> $REPORT_FILE
    cat $REPORT_FILE
}

check_cpu_utilization() {
    echo "=== CPU USAGE ===" > $REPORT_FILE
    top -b -n 1 | head -10 >> $REPORT_FILE
    cat $REPORT_FILE
}

send_email_report() {
    echo "Sending Comprehensive report via email"
    {
        echo "Subject: System Health Report"
        echo "System Health Report: "
        cat $REPORT_FILE

    } | sendmail -i -v -Am $EMAIL
}

while true; do
    echo "=============================="
    echo "System Health Check Menu"
    echo "1. Check Disk Usage"
    echo "2. Monitor Running Services"
    echo "3. Assess Memory Usage"
    echo "4. Evaluate CPU Usage"
    echo "5. Send Comprehensive report in Email"
    echo "6. Exit"
    echo "=============================="
    read -p "Select an option (1-6): " choice
    case $choice in 
        1) check_disk_usage ;;
        2) monitor_services ;;
        3) check_memory_usage ;;
        4) check_cpu_utilization ;;
        5) send_email_report ;;
        6) echo "Exiting... GoodBye!!"
           exit 0 ;;
        *) echo "Invalid option. Please select a valid choice." ;;
    esac
done