import sys
import os
import subprocess
import time
import re

# any binary having ran over 5 seconds is considered to have diverged
MAX_RUNTIME = 5


WSS_PATTERN = r"Maximum resident set size \(kbytes\):\s*(\d+)"

def stringify_row(row, delim=","):
    return delim.join(row)

def test(binaries, max):
    # if runtime is too long, don't collect more data
    too_long = [False for _ in binaries]


    data = [["n", *[os.path.basename(binary) for binary in binaries]]]
    print(stringify_row(data[0]))
    for arg in range(1, max):
        row = [str(arg)]
        for (i, binary) in enumerate(binaries):
            if too_long[i]:
                row.append("")
                continue

            start_time = time.perf_counter()

            try:

                stats = subprocess.run(
                    ["/usr/bin/time", "-v",binary, str(arg)], 
                    capture_output=True, text=True).stderr.strip()
                
                result = re.search(WSS_PATTERN, stats)
                set_size = float(result.group(1))
            except:
                raise ValueError(f"The binary {binary} failed \n{stats}")


            runtime =  time.perf_counter() - start_time 
            if runtime > MAX_RUNTIME:
                too_long[i] = True            

            row.append(str(set_size))
        
        print(stringify_row(row))
        data.append(row)
        
    with open(f"{os.path.dirname(binaries[0]).replace("bin/", "")}.txt", "w") as f:
        stringified = stringify_row([stringify_row(row) for row in data], "\n")
        f.write(stringified)
        f.close()

def main():
    if len(sys.argv) < 3:
        print("Usage: python3 eval.py <problem_name> ?<n>")

    bin_dir = os.path.join("bin", sys.argv[1])
    binaries = [os.path.join(bin_dir, bin) for bin in os.listdir(bin_dir)]
    test(binaries, int(sys.argv[2]))

if __name__ == "__main__":
    main()