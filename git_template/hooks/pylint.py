import os
import sys
from subprocess import Popen, PIPE


def exec_cmd(cmd: str) -> tuple[str, int]:
    """
    Execute external command (shell)

    :cmd: (str) external command
    :returns: tuple(str, int) command output, return code

    """
    with Popen(cmd, shell=True, stdout=PIPE, stderr=PIPE, encoding='utf-8') as proc:
        output, error = proc.communicate()
        if proc.returncode != 0:
            print("FAILED to execute:")
            print(cmd)
            print("Output message:")
            print(output)
            print("Error message:")
            print(error)
        return (output, proc.returncode)


def main() -> None:
    """
    Check commited python files with Pylint!

    """
    changed_files, _ = exec_cmd("git diff --cached --name-only HEAD")
    python_files: list[str] = []
    for f in changed_files.splitlines():
        f = f.strip()
        if not f:
            continue
        if os.path.exists(f) and os.path.isfile(f):
            file_type, _ = exec_cmd(f"file {f}")
            if "Python script" in file_type or f.endswith(".py"):
                python_files.append(f)

    exit_code: int = 0
    for f in python_files:
        _, ret_code = exec_cmd(f"pylint -E {f} 2>&1")
        if ret_code != 0:
            exit_code = 1
    sys.exit(exit_code)


if __name__ == "__main__":
    main()
