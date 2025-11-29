# Python Guide for Advent of Code

This guide covers essential Python standard library features and common patterns you'll need for solving Advent of Code problems. It's designed for returning programmers who remember coding concepts but need a refresher on Python's standard library.

## Table of Contents

1. [Working with Input](#working-with-input)
2. [Essential Data Structures](#essential-data-structures)
3. [String Manipulation](#string-manipulation)
4. [Collections Module](#collections-module)
5. [Itertools](#itertools)
6. [Regular Expressions](#regular-expressions)
7. [Math Operations](#math-operations)
8. [Grid/2D Array Operations](#grid2d-array-operations)
9. [Graph Algorithms](#graph-algorithms)
10. [Common Patterns](#common-patterns)
11. [Useful Third-Party Packages](#useful-third-party-packages)

---

## Working with Input

Your solution functions receive input as a string. Here's how to process it:

```python
def part_1(input: str) -> int:
    # Split into lines
    lines = input.strip().split('\n')

    # Or split by double newline for multi-paragraph input
    paragraphs = input.strip().split('\n\n')

    # Process each line
    for line in lines:
        # Remove leading/trailing whitespace
        line = line.strip()
        # ... process line
```

**Key methods:**

- `input.strip()` - Remove leading/trailing whitespace
- `input.split('\n')` - Split into lines
- `input.split()` - Split by any whitespace (spaces, tabs, newlines)
- `input.split(',')` - Split by comma (or any delimiter)

---

## Essential Data Structures

### Lists

```python
# Creating
my_list = [1, 2, 3]
my_list = []  # Empty list

# Common operations
my_list.append(4)        # Add to end
my_list.insert(0, 0)     # Insert at index
my_list.pop()            # Remove and return last item
my_list.pop(0)           # Remove and return first item
my_list.extend([5, 6])   # Add multiple items
my_list.reverse()        # Reverse in place
my_list.sort()           # Sort in place
sorted_list = sorted(my_list)  # Return new sorted list

# List comprehensions (very Pythonic!)
squares = [x**2 for x in range(10)]
evens = [x for x in range(10) if x % 2 == 0]
```

### Dictionaries

```python
# Creating
my_dict = {'a': 1, 'b': 2}
my_dict = {}  # Empty dict

# Accessing
value = my_dict['a']           # Raises KeyError if missing
value = my_dict.get('a', 0)    # Returns 0 if missing
value = my_dict.setdefault('a', 0)  # Set to 0 if missing, return value

# Common operations
my_dict['c'] = 3               # Add/update
del my_dict['a']               # Remove
'a' in my_dict                 # Check existence
list(my_dict.keys())           # Get all keys
list(my_dict.values())         # Get all values
list(my_dict.items())          # Get (key, value) pairs

# Dictionary comprehensions
squares_dict = {x: x**2 for x in range(10)}
```

### Sets

```python
# Creating
my_set = {1, 2, 3}
my_set = set([1, 2, 3])  # From list

# Common operations
my_set.add(4)            # Add element
my_set.remove(3)         # Remove (raises KeyError if missing)
my_set.discard(3)        # Remove (no error if missing)
my_set.pop()             # Remove and return arbitrary element

# Set operations
set1 | set2   # Union
set1 & set2   # Intersection
set1 - set2   # Difference
set1 ^ set2   # Symmetric difference
```

### Tuples

```python
# Creating
point = (3, 4)
x, y = point  # Unpacking

# Useful for coordinates, pairs, etc.
# Immutable (can't modify after creation)
```

---

## String Manipulation

```python
# Basic operations
s = "Hello World"
s.lower()           # "hello world"
s.upper()           # "HELLO WORLD"
s.strip()           # Remove leading/trailing whitespace
s.split()           # Split by whitespace
s.split(',')        # Split by comma
s.replace('a', 'b') # Replace all 'a' with 'b'
s.startswith('H')   # True
s.endswith('d')     # True
s.find('World')     # Returns index or -1
s.count('l')        # Count occurrences

# Checking
s.isdigit()         # True if all digits
s.isalpha()         # True if all letters
s.isalnum()         # True if alphanumeric

# Joining
', '.join(['a', 'b', 'c'])  # "a, b, c"

# Slicing
s[0:5]              # "Hello"
s[::-1]             # Reverse string
```

---

## Collections Module

The `collections` module provides specialized data structures:

```python
from collections import Counter, defaultdict, deque

# Counter - count occurrences
from collections import Counter
counts = Counter("hello")  # Counter({'l': 2, 'h': 1, 'e': 1, 'o': 1})
counts['l']  # 2
counts.most_common(2)  # [('l', 2), ('h', 1)]

# defaultdict - dict with default values
from collections import defaultdict
dd = defaultdict(int)      # Default to 0
dd = defaultdict(list)     # Default to []
dd['key'] += 1             # No KeyError!

# deque - double-ended queue (fast append/pop from both ends)
from collections import deque
d = deque([1, 2, 3])
d.appendleft(0)    # Add to front
d.popleft()         # Remove from front
d.append(4)         # Add to end
d.pop()             # Remove from end
```

---

## Itertools

The `itertools` module provides iterator tools:

```python
import itertools

# Combinations (order doesn't matter)
list(itertools.combinations([1, 2, 3], 2))  # [(1,2), (1,3), (2,3)]

# Permutations (order matters)
list(itertools.permutations([1, 2, 3], 2))  # [(1,2), (1,3), (2,1), ...]

# Product (Cartesian product)
list(itertools.product([1, 2], [3, 4]))  # [(1,3), (1,4), (2,3), (2,4)]

# Cycle (repeat infinitely)
for i, x in enumerate(itertools.cycle([1, 2, 3])):
    if i > 5:
        break
    print(x)  # 1, 2, 3, 1, 2, 3

# Pairwise (adjacent pairs) - Python 3.10+
list(itertools.pairwise([1, 2, 3, 4]))  # [(1,2), (2,3), (3,4)]

# Accumulate (running sum/product)
list(itertools.accumulate([1, 2, 3, 4]))  # [1, 3, 6, 10]
```

---

## Regular Expressions

For parsing complex input:

```python
import re

# Basic matching
match = re.search(r'\d+', "abc123def")  # Find first number
if match:
    number = int(match.group())  # 123

# Find all matches
numbers = re.findall(r'\d+', "abc123def456")  # ['123', '456']

# Groups
match = re.match(r'(\d+)-(\d+)', "123-456")
if match:
    first = int(match.group(1))   # 123
    second = int(match.group(2))  # 456

# Substitution
re.sub(r'\d+', 'X', "abc123def")  # "abcXdef"

# Common patterns
r'\d+'           # One or more digits
r'\d'            # Single digit
r'[a-z]+'        # One or more lowercase letters
r'[A-Za-z]+'     # One or more letters
r'\s+'           # One or more whitespace
r'.'             # Any character
r'^start'        # Starts with
r'end$'          # Ends with
```

---

## Math Operations

```python
import math

# Basic
abs(-5)              # 5
min(1, 2, 3)         # 1
max(1, 2, 3)         # 3
sum([1, 2, 3])       # 6
pow(2, 3)            # 8 (or 2**3)

# Math module
math.floor(3.7)      # 3
math.ceil(3.2)       # 4
math.sqrt(16)        # 4.0
math.gcd(12, 8)      # 4 (greatest common divisor)
math.lcm(12, 8)       # 24 (least common multiple) - Python 3.9+
math.factorial(5)    # 120

# Useful for AoC
divmod(17, 5)        # (3, 2) - quotient and remainder
```

---

## Grid/2D Array Operations

Many AoC problems involve 2D grids:

```python
# Representing a grid
grid = []
for line in input.strip().split('\n'):
    grid.append(list(line))  # Each row is a list

# Or with list comprehension
grid = [list(line) for line in input.strip().split('\n')]

# Accessing
grid[row][col]       # Get value at (row, col)
rows, cols = len(grid), len(grid[0])  # Dimensions

# Common neighbor patterns (4-directional)
directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]  # right, down, left, up

# 8-directional (including diagonals)
directions = [
    (-1, -1), (-1, 0), (-1, 1),
    (0, -1),           (0, 1),
    (1, -1),  (1, 0),  (1, 1)
]

# Check bounds
def in_bounds(row, col, grid):
    return 0 <= row < len(grid) and 0 <= col < len(grid[0])

# Iterate neighbors
for dr, dc in directions:
    nr, nc = row + dr, col + dc
    if in_bounds(nr, nc, grid):
        # Process neighbor at (nr, nc)
        pass

# Using coordinates as keys
grid_dict = {}
for r, row in enumerate(grid):
    for c, val in enumerate(row):
        grid_dict[(r, c)] = val
```

---

## Graph Algorithms

### Breadth-First Search (BFS)

```python
from collections import deque

def bfs(start, target, neighbors_func):
    """Find shortest path using BFS."""
    queue = deque([(start, 0)])  # (node, distance)
    visited = {start}

    while queue:
        node, dist = queue.popleft()

        if node == target:
            return dist

        for neighbor in neighbors_func(node):
            if neighbor not in visited:
                visited.add(neighbor)
                queue.append((neighbor, dist + 1))

    return None  # Not found
```

### Depth-First Search (DFS)

```python
def dfs(node, visited, neighbors_func):
    """DFS traversal."""
    visited.add(node)

    for neighbor in neighbors_func(node):
        if neighbor not in visited:
            dfs(neighbor, visited, neighbors_func)
```

### Dijkstra's Algorithm (Shortest Path)

```python
import heapq

def dijkstra(start, target, neighbors_func):
    """Find shortest path with weighted edges."""
    # neighbors_func(node) should return [(neighbor, weight), ...]
    heap = [(0, start)]  # (distance, node)
    distances = {start: 0}
    visited = set()

    while heap:
        dist, node = heapq.heappop(heap)

        if node in visited:
            continue
        visited.add(node)

        if node == target:
            return dist

        for neighbor, weight in neighbors_func(node):
            new_dist = dist + weight
            if neighbor not in distances or new_dist < distances[neighbor]:
                distances[neighbor] = new_dist
                heapq.heappush(heap, (new_dist, neighbor))

    return None
```

---

## Common Patterns

### Parsing Numbers from Input

```python
# Single number per line
numbers = [int(line) for line in input.strip().split('\n')]

# Multiple numbers per line
for line in input.strip().split('\n'):
    nums = [int(x) for x in line.split()]

# Using regex
import re
numbers = [int(x) for x in re.findall(r'\d+', input)]
```

### Sliding Window

```python
# Window of size 3
window_size = 3
for i in range(len(data) - window_size + 1):
    window = data[i:i+window_size]
    # Process window
```

### Two-Pointer Technique

```python
left, right = 0, len(data) - 1
while left < right:
    # Process data[left] and data[right]
    if condition:
        left += 1
    else:
        right -= 1
```

### Memoization (Caching)

```python
from functools import cache

@cache  # Python 3.9+
def fibonacci(n):
    if n <= 1:
        return n
    return fibonacci(n-1) + fibonacci(n-2)

# Or manually
cache = {}
def fibonacci(n):
    if n in cache:
        return cache[n]
    if n <= 1:
        result = n
    else:
        result = fibonacci(n-1) + fibonacci(n-2)
    cache[n] = result
    return result
```

### Enumerate (Get Index While Iterating)

```python
for i, value in enumerate(['a', 'b', 'c']):
    print(i, value)  # 0 a, 1 b, 2 c
```

### Zip (Iterate Multiple Lists)

```python
list1 = [1, 2, 3]
list2 = ['a', 'b', 'c']
for num, letter in zip(list1, list2):
    print(num, letter)  # 1 a, 2 b, 3 c
```

### Any/All

```python
numbers = [2, 4, 6, 8]
all_even = all(x % 2 == 0 for x in numbers)  # True
any_odd = any(x % 2 == 1 for x in numbers)   # False
```

---

## Useful Third-Party Packages

While the standard library covers most needs, these are popular and worth knowing:

### NumPy (for numerical/grid operations)

```python
import numpy as np

# Create 2D array
grid = np.array([[1, 2, 3], [4, 5, 6]])

# Common operations
grid.sum()           # Sum all elements
grid.max()           # Maximum value
grid.T               # Transpose
np.roll(grid, 1, axis=0)  # Shift rows
```

**Note:** NumPy is great for performance, but most AoC problems can be solved with standard library. Only use if you need heavy numerical computation.

### NetworkX (for complex graph problems)

```python
import networkx as nx

G = nx.Graph()
G.add_edge('A', 'B', weight=5)
shortest_path = nx.shortest_path(G, 'A', 'B')
```

**Note:** Most graph problems can be solved with BFS/DFS from stdlib. NetworkX is useful for very complex graph algorithms.

---

## Quick Reference: Common AoC Patterns

### Parse "x,y" coordinates

```python
x, y = map(int, line.split(','))
```

### Parse "key: value" pairs

```python
key, value = line.split(':')
value = value.strip()
```

### Count occurrences

```python
from collections import Counter
counts = Counter(items)
most_common = counts.most_common(1)[0]
```

### Find min/max with key

```python
min_item = min(items, key=lambda x: x.some_property)
max_item = max(items, key=lambda x: x.some_property)
```

### Group consecutive items

```python
from itertools import groupby
groups = [list(g) for k, g in groupby(items, key=lambda x: x)]
```

### Rotate/flip grid

```python
# Rotate 90 degrees clockwise
rotated = list(zip(*grid[::-1]))

# Flip horizontally
flipped = [row[::-1] for row in grid]
```

---

## Tips

1. **Start simple**: Most problems can be solved with basic data structures and loops
2. **Use list comprehensions**: They're Pythonic and often more readable
3. **Don't overthink**: AoC problems are designed to be solvable with standard approaches
4. **Test with examples**: Always verify your solution works on the provided example
5. **Read carefully**: Input parsing is often the trickiest part

---

## Additional Resources

- [Python Standard Library Documentation](https://docs.python.org/3/library/)
- [Python Built-in Functions](https://docs.python.org/3/library/functions.html)
- [Python Data Structures](https://docs.python.org/3/tutorial/datastructures.html)

Happy coding! 🎄
