# Advent of Code Python Runner

A simple CLI tool for managing and running Advent of Code solutions in Python.

## Quick Start

1. **Create a new day** (automatically fetches input if token is configured):
   ```bash
   python3 src/main.py new 1
   ```

2. **Write your solution** in `src/2025/day_1.py`:
   ```python
   def part_1(input: str) -> int:
       # Your solution here
       return 42
   
   def part_2(input: str) -> int:
       # Your solution here
       return 24
   ```

3. **Run your solution**:
   ```bash
   python3 src/main.py run 1
   ```

## Setup

### Optional: Configure Token for Auto-Fetching Input

To automatically fetch input from the Advent of Code website, create a `.env.toml` file in the project root:

```toml
token = "your_session_token_here"
```

**How to get your session token:**
1. Log in to [adventofcode.com](https://adventofcode.com)
2. Open your browser's developer tools (F12)
3. Go to the Application/Storage tab → Cookies
4. Copy the value of the `session` cookie
5. Paste it into `.env.toml`

**Note:** The `.env.toml` file is not tracked by git (should be in `.gitignore`). Never commit your session token!

Without a token, you can still use the tool - you'll just need to manually create input files.

## Commands

### `new` - Create Template Files for a New Day

Creates the solution template and input file for a day.

```bash
python3 src/main.py new <day> [--year YEAR]
```

**Arguments:**
- `day` (optional): Day number (1-25). If omitted and current date is December 1-25, uses the current day.
- `--year` (optional): Year (defaults to current year)

**Examples:**
```bash
# Create day 1 for current year
python3 src/main.py new 1

# Create day 1 for 2024
python3 src/main.py new 1 --year 2024

# During December 1-25, create today's day automatically
python3 src/main.py new
```

**What it does:**
- Creates `src/{year}/day_{day}.py` with template functions (if it doesn't exist)
- Creates `input/{year}/{day}.txt` (fetches from AoC API if token is configured, otherwise creates empty file)
- Never overwrites existing source files (warns if they exist)
- Always fetches/overwrites input files if token is available

### `run` - Run a Day's Solution

Runs both parts of a day's solution and compares against expected results.

```bash
python3 src/main.py run <day> [--year YEAR] [--example]
```

**Arguments:**
- `day` (required): Day number (1-25)
- `--year` (optional): Year (defaults to current year)
- `--example` (optional): Use example input file instead of real input

**Examples:**
```bash
# Run day 1 for current year
python3 src/main.py run 1

# Run day 1 for 2024
python3 src/main.py run 1 --year 2024

# Run with example input
python3 src/main.py run 1 --example
```

**Output:**
- If expected results are configured in `aoc.toml`, shows ✅ or ❌ with comparison
- If no expected results, just shows the computed result

**Example output:**
```
Part 1: ✅
Part 2: ❌
  Expected: 42
  Received: 24
```

## Expected Results

You can configure expected results in `aoc.toml` to automatically verify your solutions:

```toml
[aoc.2025.1]
pt_1 = 123
pt_2 = 456

[aoc.2025.2]
pt_1 = 789
pt_2 = 101112
```

**Format:**
- `[aoc.{year}.{day}]` - Section for a specific day
- `pt_1 = <value>` - Expected result for part 1
- `pt_2 = <value>` - Expected result for part 2

When you run a solution, it will compare your result against these values and show ✅ or ❌.

**Note:** Expected results are only checked when running with real input (not with `--example`).

## Example Input Files

You can create example input files for testing. Name them `{day}.example.txt` in the `input/{year}/` directory:

```
input/
  2025/
    1.txt          # Real input
    1.example.txt  # Example input for testing
```

Run with example input:
```bash
python3 src/main.py run 1 --example
```

## Project Structure

```
.
├── src/
│   ├── main.py           # CLI runner
│   └── {year}/
│       └── day_{day}.py  # Your solutions
├── input/
│   └── {year}/
│       ├── {day}.txt           # Real input
│       └── {day}.example.txt   # Example input (optional)
├── aoc.toml              # Expected results (optional)
├── .env.toml             # Session token (optional, not tracked)
├── README.md             # This file
└── guide.md              # Python reference guide
```

## Solution Template

Each day's solution file should have this structure:

```python
def part_1(input: str) -> int:
    """
    Solve part 1 of the puzzle.
    
    Args:
        input: The puzzle input as a string
        
    Returns:
        The answer as an integer
    """
    # Your solution here
    return 0

def part_2(input: str) -> int:
    """
    Solve part 2 of the puzzle.
    
    Args:
        input: The puzzle input as a string
        
    Returns:
        The answer as an integer
    """
    # Your solution here
    return 0
```

**Important:**
- Both functions are required
- Functions receive input as a string (you parse it)
- Functions must return an integer
- The input string includes trailing newlines - use `.strip()` if needed

## Tips

1. **Start with the example**: Use `--example` flag to test with smaller example input
2. **Parse carefully**: Input parsing is often the trickiest part - check the format carefully
3. **Use the guide**: See `guide.md` for Python standard library reference
4. **Test incrementally**: Run your solution often as you develop it
5. **Check expected results**: Configure `aoc.toml` to catch regressions

## Troubleshooting

**"Module not found" error:**
- Make sure you've created the day file: `python3 src/main.py new <day>`
- Check the file is at `src/{year}/day_{day}.py`

**"Input file not found" error:**
- Create the input file manually, or
- Configure your token in `.env.toml` and run `new` command again

**"part_1/part_2 function not found" error:**
- Make sure your solution file has both `part_1` and `part_2` functions
- Check function names are exactly `part_1` and `part_2` (lowercase, underscore)

**Token not working:**
- Verify your session token is correct in `.env.toml`
- Check the token hasn't expired (AoC tokens can expire)
- Make sure the format is: `token = "your_token_here"` (with quotes)

## See Also

- [guide.md](guide.md) - Python standard library reference for AoC
- [Advent of Code](https://adventofcode.com) - The puzzle website

