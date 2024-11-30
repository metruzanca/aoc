# Language agnostic "Advent of Code" setup

Powered by [GreenLightning/advent-of-code-downloader](https://github.com/GreenLightning/advent-of-code-downloader) to download input files.

## Getting started

Install the CLI with golang (or use [pre-built binaries](https://github.com/GreenLightning/advent-of-code-downloader/releases/latest/))

```bash
go install github.com/GreenLightning/advent-of-code-downloader/aocdl@latest
```

Authenticate yourself and grab your [adventofcode.com](https://adventofcode.com) session token (lasts 1 month) and add it to `.aocdlconfig`. You can create a template with:

```bash
cp .aocdlconfig.example .aocdlconfig;
```

**⭐️ Get today ⭐️**

```bash
mkdir -p 2024/inputs/
aocdl
```

Optionally: get in the mood with an _icy_ editor theme like `freethinkel.snowfall`(vscode) or Nord for most editors.

## Language Recommendations

Generally create a folder with the language name in the root of the repo. This way you can re-use utils cross year.

### Gleam

Gleam will complain if you create a new package starting with `gleam` so heres what you need to do:

```bash
cd 2024;
gleam new --name aoc_2024 gleam;
```

Recommend using [gladvent](https://hexdocs.pm/gladvent) to take care of running your aoc files / parts. Though it does require moving the inputs directory.

### Javascript

Don't.

### Typescript

I find that either [bun](https://bun.sh) or [tsx](https://npmjs.com/package/tsx) provide the simplest setup.

You can very simply run `.ts` files with either of these. You don't need a tsconfig. Simply just the ts files.
