import sys
import os
import subprocess
import time

# any binary having ran over 5 seconds is considered to have diverged
MAX_RUNTIME = 1

def stringify_row(row, delim=","):
    return delim.join(row)

def test_fib(binaries, max=86):
    # if runtime is too long, don't collect more data
    too_long = [False for _ in binaries]
    data = ["n"] + binaries

    print(stringify_row(data))
    for arg in range(max):
        prev_result = None
        row = [str(arg)]
        for (i, binary) in enumerate(binaries):
            if too_long[i]:
                row.append("")
                continue

            start_time = time.perf_counter()

            result = subprocess.run(
                [f"binaries/{binary}", str(arg)], 
                capture_output=True, text=True).stdout.strip()
            
            runtime =  time.perf_counter() - start_time 
            if runtime > MAX_RUNTIME:
                too_long[i] = True            

            if prev_result is not None and result != prev_result:
                raise ValueError(f"The binary {binary} failed returned {result} when others returned {prev_result}")

            prev_result = result
            row.append(str(runtime))
        
        print(stringify_row(row))
        data.append(row)
    
    with open("results.txt", "w") as f:
        stringified = stringify_row([stringify_row(row) for row in data], "\n")
        f.write(stringified)
        f.close()

def main():
    binaries = os.listdir("binaries")
    test_fib(binaries, int(sys.argv[1]))

if __name__ == "__main__":
    main()