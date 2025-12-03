#!/usr/bin/env python3
import subprocess
import sys
import re
import argparse
import shutil

def main():
    """
    Executa um comando sob a supervisão do strace para monitorar o acesso a arquivos,
    com opções avançadas de filtragem e saída.
    """
    parser = argparse.ArgumentParser(
        description="Monitors file access of a given command using strace.",
        epilog="""Examples:
  # Monitor a simple command and print to console
  %(prog)s ls -l /etc

  # Monitor a Node.js app and save the output to a file
  %(prog)s -o access.log node my_app.js

  # Monitor and only include paths containing '/etc/'
  %(prog)s --include /etc/ ls -la /etc /usr/lib

  # Monitor and exclude paths containing '.so'
  %(prog)s --exclude .so -- top
""",
        formatter_class=argparse.RawTextHelpFormatter
    )
    parser.add_argument(
        '-o', '--output',
        metavar='<file>',
        help='File to save the access log. Defaults to standard output.'
    )
    parser.add_argument(
        '--include',
        metavar='<pattern>',
        help='Only show paths containing this pattern (case-insensitive).'
    )
    parser.add_argument(
        '--exclude',
        metavar='<pattern>',
        help='Exclude paths containing this pattern (case-insensitive).'
    )
    parser.add_argument(
        'command',
        nargs=argparse.REMAINDER,
        help='The command to execute and monitor. All arguments after the options will be treated as the command.'
    )

    args = parser.parse_args()

    if not args.command:
        parser.print_help()
        sys.exit(1)

    command_to_run = args.command

    if shutil.which("strace") is None:
        print("Error: 'strace' not found. Please install it to use this script.", file=sys.stderr)
        print("Common install command: sudo apt-get install strace (Debian/Ubuntu) or sudo dnf install strace (Fedora/CentOS)", file=sys.stderr)
        sys.exit(1)

    strace_command = [
        "strace",
        "-e", "trace=open,openat,access,stat,lstat",
        "-f",
        "-o", "/dev/stderr",
        "--"
    ] + command_to_run

    print(f"[MONITOR] Executing command: {' '.join(command_to_run)}", file=sys.stderr)
    if args.output:
        print(f"[MONITOR] Logging accessed files to: {args.output}", file=sys.stderr)
    print("[MONITOR] Pressione Ctrl+C para parar o monitoramento.", file=sys.stderr)
    print("-" * 50, file=sys.stderr)

    output_file = open(args.output, 'w') if args.output else sys.stdout
    
    try:
        process = subprocess.Popen(strace_command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True, bufsize=1)
        path_regex = re.compile(r'(?:open|openat|access|stat|lstat)\(.*?"(.*?)"')
        accessed_files = set()

        for line in process.stderr:
            match = path_regex.search(line)
            if match:
                file_path = match.group(1)
                
                if not file_path.startswith("/"):
                    continue
                
                if args.include and args.include.lower() not in file_path.lower():
                    continue
                    
                if args.exclude and args.exclude.lower() in file_path.lower():
                    continue

                if file_path not in accessed_files:
                    accessed_files.add(file_path)
                    try:
                        output_file.write(f"[ACCESS] {file_path}\n")
                    except IOError:
                        # Handle cases where the pipe might be closed, e.g., when piping to `head`
                        break


    except KeyboardInterrupt:
        print("\n[MONITOR] Interruption received. Shutting down...", file=sys.stderr)
    except Exception as e:
        print(f"\n[MONITOR] An error occurred: {e}", file=sys.stderr)
    finally:
        if 'process' in locals() and process.poll() is None:
            process.terminate()
            try:
                process.wait(timeout=5)
            except subprocess.TimeoutExpired:
                process.kill()
        if args.output and not output_file.closed:
            output_file.close()
        print("[MONITOR] Monitoring stopped.", file=sys.stderr)

if __name__ == "__main__":
    main()
