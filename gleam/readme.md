# Glem usage

Create gleam files and fetch your input

```bash
gleam run new 1 --year=2024;
aocdl -year 2024 -day 1 --force;
```

Run gleam file

```bash
gleam run run --year=2024 1
```

## Tips

- Use `io.debug()` for print debugging as that makes it thru the runner into stdout.
- Write tests
