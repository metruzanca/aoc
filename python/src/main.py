import argparse
import importlib.util
import sys
import tomllib
import urllib.request
import urllib.error
from datetime import datetime
from pathlib import Path
from typing import Any


def load_pyproject(project_root: Path) -> dict[str, Any] | None:
    """Load aoc.toml if it exists, return None otherwise."""
    pyproject_path = project_root / "aoc.toml"
    if pyproject_path.exists():
        with open(pyproject_path, "rb") as f:
            return tomllib.load(f)
    return None


def load_env_token(project_root: Path) -> str | None:
    """Load token from .env.toml if it exists, return None otherwise."""
    env_path = project_root / ".env.toml"
    if not env_path.exists():
        return None
    
    try:
        with open(env_path, "rb") as f:
            env_data = tomllib.load(f)
            token = env_data.get("token")
            return token if isinstance(token, str) else None
    except (OSError, tomllib.TOMLDecodeError) as e:
        print(f"Warning: Failed to read .env.toml: {e}", file=sys.stderr)
        return None


def fetch_aoc_input(year: int, day: int, token: str) -> str | None:
    """Fetch input from Advent of Code API. Returns None on error."""
    url = f"https://adventofcode.com/{year}/day/{day}/input"
    
    req = urllib.request.Request(url)
    req.add_header("Cookie", f"session={token}")
    req.add_header("User-Agent", "github.com/szanca/aoc by szanca@example.com")
    
    try:
        with urllib.request.urlopen(req) as response:
            return response.read().decode("utf-8").rstrip()
    except urllib.error.HTTPError as e:
        if e.code == 404:
            print(f"Warning: Input not available yet for {year} day {day}", file=sys.stderr)
        elif e.code == 400:
            print("Warning: Bad request - token may be invalid", file=sys.stderr)
        else:
            print(f"Warning: Failed to fetch input: HTTP {e.code}", file=sys.stderr)
        return None
    except (urllib.error.URLError, OSError) as e:
        print(f"Warning: Failed to fetch input: {e}", file=sys.stderr)
        return None


def import_day_module(year: int, day: int, project_root: Path) -> Any:
    """Dynamically import the day module."""
    module_path = project_root / "src" / str(year) / f"day_{day}.py"
    
    if not module_path.exists():
        print(f"Error: Module not found at {module_path}", file=sys.stderr)
        sys.exit(1)
    
    spec = importlib.util.spec_from_file_location(f"day_{day}", module_path)
    if spec is None or spec.loader is None:
        print(f"Error: Failed to create module spec for {module_path}", file=sys.stderr)
        sys.exit(1)
    
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    
    return module


def read_input_file(year: int, day: int, example: bool, project_root: Path) -> str:
    """Read the input file for the given year and day."""
    filename = f"{day}.example.txt" if example else f"{day}.txt"
    input_path = project_root / "input" / str(year) / filename
    
    if not input_path.exists():
        print(f"Error: Input file not found at {input_path}", file=sys.stderr)
        sys.exit(1)
    
    with open(input_path, "r", encoding="utf-8") as f:
        return f.read()


def get_expected_result(pyproject: dict[str, Any] | None, year: int, day: int, part: int) -> Any:
    """Get expected result from aoc.toml if available."""
    if pyproject is None:
        return None
    
    # TOML parses [aoc.2024.1] as nested keys: aoc -> 2024 -> 1
    if "aoc" not in pyproject:
        return None
    
    if str(year) not in pyproject["aoc"]:
        return None
    
    if str(day) not in pyproject["aoc"][str(year)]:
        return None
    
    part_key = f"pt_{part}"
    day_data = pyproject["aoc"][str(year)][str(day)]
    
    if part_key not in day_data:
        return None
    
    return day_data[part_key]


def get_default_day() -> int | None:
    """Get the current day if it's between Dec 1-25, otherwise return None."""
    now = datetime.now()
    if now.month == 12 and 1 <= now.day <= 25:
        return now.day
    return None


def create_day_files(year: int, day: int) -> None:
    """Create template files for a new day."""
    project_root = Path(__file__).parent.parent
    
    # Try to fetch input from AoC API if token is available (always fetch to overwrite)
    token = load_env_token(project_root)
    input_content = None
    if token:
        input_content = fetch_aoc_input(year, day, token)
    
    # Create input file (always overwrite if we fetched content)
    input_dir = project_root / "input" / str(year)
    input_dir.mkdir(parents=True, exist_ok=True)
    input_file = input_dir / f"{day}.txt"
    
    if input_content:
        was_existing = input_file.exists()
        input_file.write_text(input_content)
        if was_existing:
            print(f"Fetched and overwrote: {input_file}")
        else:
            print(f"Fetched and saved: {input_file}")
    elif input_file.exists():
        print(f"Warning: Input file already exists at {input_file} (no token to fetch)", file=sys.stderr)
    else:
        input_file.touch()
        print(f"Created: {input_file}")
    
    # Create source file (never overwrite if it exists)
    src_dir = project_root / "src" / str(year)
    src_dir.mkdir(parents=True, exist_ok=True)
    src_file = src_dir / f"day_{day}.py"
    
    if src_file.exists():
        print(f"Warning: Source file already exists at {src_file} (not overwritten)", file=sys.stderr)
    else:
        template = """def part_1(input: str) -> int:
  pass

def part_2(input: str) -> int:
  pass
"""
        src_file.write_text(template)
        print(f"Created: {src_file}")


def run_day(year: int, day: int, example: bool):
    """Run the specified day's solution."""
    project_root = Path(__file__).parent.parent
    
    # Load aoc.toml
    pyproject = load_pyproject(project_root)
    
    # Import the day module
    module = import_day_module(year, day, project_root)
    
    # Read input file
    input_data = read_input_file(year, day, example, project_root)
    
    # Run part 1
    if not hasattr(module, "part_1"):
        print(f"Error: part_1 function not found in day_{day}.py", file=sys.stderr)
        sys.exit(1)
    
    result_1 = module.part_1(input_data)
    expected_1 = None if example else get_expected_result(pyproject, year, day, 1)
    
    # Display part 1 results
    if expected_1 is not None:
        status_1 = "✅" if result_1 == expected_1 else "❌"
        print(f"Part 1: {status_1}")
        if result_1 != expected_1:
            print(f"  Expected: {expected_1}")
            print(f"  Received: {result_1}")
    else:
        print(f"Part 1: {result_1}")
    
    # Run part 2
    if not hasattr(module, "part_2"):
        print(f"Error: part_2 function not found in day_{day}.py", file=sys.stderr)
        sys.exit(1)
    
    result_2 = module.part_2(input_data)
    expected_2 = None if example else get_expected_result(pyproject, year, day, 2)
    
    # Display part 2 results
    if expected_2 is not None:
        status_2 = "✅" if result_2 == expected_2 else "❌"
        print(f"Part 2: {status_2}")
        if result_2 != expected_2:
            print(f"  Expected: {expected_2}")
            print(f"  Received: {result_2}")
    else:
        print(f"Part 2: {result_2}")


def main() -> None:
    parser = argparse.ArgumentParser(description="Advent of Code runner")
    subparsers = parser.add_subparsers(dest="command", help="Commands")
    
    current_year = datetime.now().year
    
    run_parser = subparsers.add_parser("run", help="Run a day's solution")
    run_parser.add_argument("day", type=int, help="Day number (1-25)")
    run_parser.add_argument("--year", type=int, default=current_year,
                           help=f"Year (default: {current_year})")
    run_parser.add_argument("--example", action="store_true",
                           help="Use example input file (default: False)")
    
    new_parser = subparsers.add_parser("new", help="Create template files for a new day")
    new_parser.add_argument("day", type=int, nargs="?", default=None,
                           help="Day number (1-25). If omitted and current date is Dec 1-25, uses current day")
    new_parser.add_argument("--year", type=int, default=current_year,
                           help=f"Year (default: {current_year})")
    
    args = parser.parse_args()
    
    if args.command == "run":
        run_day(args.year, args.day, args.example)
    elif args.command == "new":
        # Determine day
        if args.day is not None:
            day = args.day
        else:
            day = get_default_day()
            if day is None:
                print("Error: Day not provided and current date is not between Dec 1-25.", file=sys.stderr)
                print("Please provide a day: python3 src/main.py new <day>", file=sys.stderr)
                sys.exit(1)
        
        if not (1 <= day <= 25):
            print(f"Error: Day must be between 1 and 25, got {day}", file=sys.stderr)
            sys.exit(1)
        
        create_day_files(args.year, day)
    else:
        parser.print_help()


if __name__ == "__main__":
    main()