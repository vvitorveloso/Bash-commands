#!/bin/bash

show_help() {
cat << EOF
Usage: $(basename "$0") [-o <output_file>] -- <command_to_trace>

This script monitors the system calls of a given command using strace.
It's designed to identify which files an application accesses, which is useful
for understanding its behavior and identifying potential hardware information leaks.

Dependencies:
  - strace: This script requires 'strace' to be installed.
            (e.g., 'sudo apt-get install strace' or 'sudo dnf install strace')

Options:
  -o <output_file>  Specify a file to save the full strace log.
                    Default: /tmp/syscall_trace_<timestamp>.log
  -h, --help        Show this help message.

Examples:
  # Trace the 'ls -l /etc' command and save to default log file
  $(basename "$0") -- ls -l /etc

  # Trace a node application and save the log to a specific file
  $(basename "$0") -o my_app_trace.log -- node my_app.js

  # Trace an electron application (quotes are important)
  $(basename "$0") -- 'electron /path/to/app'
EOF
}

LOG_FILE="/tmp/syscall_trace_$(date +%s).log"
COMMAND_ARGS=()

# Parse arguments
while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        -o)
        LOG_FILE="$2"
        shift # past argument
        shift # past value
        ;;
        -h|--help)
        show_help
        exit 0
        ;;
        --)
        shift # past the '--'
        COMMAND_ARGS=($@)
        break
        ;;
        *)
        # if no other arguments are recognized, assume it's the command
        COMMAND_ARGS=($@)
        break
        ;;
    esac
done

# Check for strace
if ! command -v strace &> /dev/null; then
    echo "Error: 'strace' is not installed. Please install it to use this script." >&2
    exit 1
fi

if [ ${#COMMAND_ARGS[@]} -eq 0 ]; then
    show_help
    exit 1
fi

COMMAND="${COMMAND_ARGS[*]}"

echo "Tracing system calls for command: $COMMAND"
echo "Logging to: $LOG_FILE"

# Using strace to capture file-related system calls
strace -f -e trace=openat,open,read,write,stat,lstat,access -o "$LOG_FILE" bash -c "$COMMAND" &
STRACE_PID=$!

echo "strace running with PID: $STRACE_PID"
echo "Press Ctrl+C to stop tracing"

# Wait for completion or interruption
wait $STRACE_PID

echo "Tracing finished. Results are in $LOG_FILE"

# Filter for relevant hardware identification files
echo
echo "--- Hardware-related file access detected: ---"
grep -i -E "(cpuinfo|meminfo|dmi|/sys/class/|/proc/|/dev/|/sys/devices)" "$LOG_FILE" --color=always || echo "No common hardware-related files found in trace."
echo "----------------------------------------------"
echo "For a full list of accessed files, run: grep -E 'openat|access' \"$LOG_FILE\""
