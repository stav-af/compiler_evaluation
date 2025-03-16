
import subprocess

def run(cmd):
    result = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True, shell=True)

    if result.returncode == 0:
        print("Build successful!")
    else:
        print("Build failed.")
        print("STDOUT:", result.stdout)
        print("STDERR:", result.stderr)


def main():
    cmds = [
        "clang source/fib_c.c -o binaries/fib_c",
        "pyinstaller --onefile source/fib_py.py --distpath binaries",
        "ghc --make source/fib_hs.hs -o binaries/fib_hs",
        "ocamlc -o binaries/fib_ml source/fib_ml.ml",
        "cd source/scalap && sbt nativeLink && cp target/*/*-out ../../binaries/fib_scala && cd ../..",
        "raco exe -o binaries/fib_sch source/fib_sch.rkt"
    ]
    
    [run(cmd) for cmd in cmds]

if __name__ == "__main__":
    main()