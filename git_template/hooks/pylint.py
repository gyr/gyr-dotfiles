import sys
from subprocess import Popen, PIPE, DEVNULL


def exec_cmd(cmd):
    """
    Execute external command (shell)

    :cmd: (str) external command
    :returns: tuple(str, int) command output, return code

    """
    proc = Popen(cmd, shell=True, stdout=PIPE, stderr=PIPE, encoding='utf-8')
    output, error = proc.communicate()
    if proc.returncode != 0:
        print("FAILED to execute:")
        print(cmd)
        print("Error message:")
        print(error)
        print(output)
    return output, proc.returncode


def main():
    """
    Check commited python files with Pylint!

    """
    changed_files, ret_code = exec_cmd("git diff --cached --name-only HEAD")
    python_files = []
    for f in changed_files.splitlines():
        f = f.strip()
        if not f:
            continue
        file_type, ret_code = exec_cmd("file {}".format(f))
        if "Python script" in file_type or f.endswith(".py"):
            python_files.append(f)

    exit_code = 0
    for f in python_files:
        out, ret_code = exec_cmd("pylint -E {} 2>&1".format(f))
        if ret_code != 0:
            print(out)
            exit_code = 1
    sys.exit(exit_code)


if __name__ == "__main__":
    main()
