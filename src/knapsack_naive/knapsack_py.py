import sys

def nats(start):
    while True:
        yield start
        start += 1.0

def take(n, gen):
    result = []
    for _ in range(n):
        result.append(next(gen))
    return result

def knapSack(weights, values, capacity):
    if len(weights) == 0 or len(values) == 0:
        return 0.0
    if capacity < 0.0:
        return 0.0

    whead = weights[0]
    vhead = values[0]

    if whead > capacity:
        return knapSack(weights[1:], values[1:], capacity)
    else:
        excludeVal = knapSack(weights[1:], values[1:], capacity)
        includeVal = vhead + knapSack(weights[1:], values[1:], capacity - whead)
        return max(excludeVal, includeVal)

if __name__ == "__main__":
    n = int(sys.argv[1])  
    
    big_weights = take(n, nats(1.0))
    big_values  = take(n, nats(10.0))

    result = knapSack(big_weights, big_values, 400.0)
    print(result)
