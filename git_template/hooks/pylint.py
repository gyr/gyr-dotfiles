import sys
from subprocess import Popen, PIPE


def exec_cmd(cmd):
    """
    Execute external command (shell)

    :cmd: (str) external command
    :returns: tuple(str, int) command output, return code

    """
    proc = Popen(cmd, shell=True, stdout=PIPE, stderr=PIPE)
    output, error = proc.communicate()
    if proc.returncode != 0:
        print "FAILED to execute:"
        print str(cmd)
        print "Error message:"
        print str(error)
        print str(output)
    return output, proc.returncode


def main():
    """
    Check commited python files with Pylint!

    """
    changed_files, ret_code = exec_cmd("git diff --staged --name-only HEAD")
    python_files = []
    for f in changed_files.split():
        file_type, ret_code = exec_cmd("file {}".format(f))
        if "Python script" in file_type or f.endswith(".py"):
            python_files.append(f)

    exit_code = 0
    for f in python_files:
        out, ret_code = exec_cmd("pylint -E {}".format(f))
        if ret_code != 0:
            exit_code = 1
    sys.exit(exit_code)


if __name__ == "__main__":
    main()
