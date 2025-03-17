import os
import sys
import subprocess

compile_cmds = {
        "c"   : "clang {src} -o {dst}",
        "py"  : "pyinstaller --onefile {src} --distpath {bindir} --name {name}",
        "hs"  : "ghc --make {src} -o {dst}",
        "ml"  : "ocamlc -o {dst} {src}",
        "rkt" : "raco exe -o {dst} {src}",
        "scala": (
            "cd {srcdir} && "
            "sbt nativeLink && "
            "cp target/*/*-out ../../{dst}"
        ),
    }

def exec_cmd(cmd):
    result = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True, shell=True)

    if result.returncode == 0:
        print("Build successful!")
    else:
        print("Build failed.")
        print("STDOUT:", result.stdout)
        print("STDERR:", result.stderr)


def compile(srcs_dsts):
    for (source, dest) in srcs_dsts:
        ext = source.split(".")[-1]
        print(ext)
        if ext not in compile_cmds.keys():
            continue

        cmd_template = compile_cmds[ext]
        cmd = cmd_template.format(
            src=source,
            dst=dest.split(".")[0],
            bindir=os.path.dirname(dest),
            name=os.path.basename(dest).split(".")[0],
            srcdir=os.path.dirname(source)
        )
        exec_cmd(cmd)

def main():
    if len(sys.argv) < 2:
        print("Usage: build.py <solution_name>")
        sys.exit(1)

    problem_name = sys.argv[1]
    
    src_dir = os.path.join("src", problem_name)
    bin_dir = os.path.join("bin", problem_name)

    os.makedirs(bin_dir, exist_ok=True)
    
    solutions = os.listdir(src_dir)

    srcs = [os.path.join(src_dir, fname) for fname in solutions]
    dsts = [os.path.join(bin_dir, fname) for fname in solutions]

    compile(zip(srcs, dsts))
    




if __name__ == "__main__":
    main()