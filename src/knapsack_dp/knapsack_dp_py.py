import sys

def knapSackDP(weights, values, capacity):
    n = len(weights)
    cap = int(capacity)
    # dp[i][c] = best value using first i items at capacity c
    dp = [[0.0]*(cap+1) for _ in range(n+1)]
    
    for i in range(1, n+1):
        w = int(weights[i-1])  # cast to int
        v = values[i-1]
        for c in range(cap+1):
            if w > c:
                dp[i][c] = dp[i-1][c]
            else:
                excludeVal = dp[i-1][c]
                includeVal = v + dp[i-1][c - w]
                dp[i][c] = max(excludeVal, includeVal)

    return dp[n][cap]

if __name__ == "__main__":
    n = int(sys.argv[1])  # no input validation
    # big_weights = [1..n], big_values = [10..(9+n)]
    big_weights = [float(i) for i in range(1, n+1)]
    big_values  = [float(i) for i in range(10, 10+n)]
    
    answer = knapSackDP(big_weights, big_values, 400.0)
    print(answer)