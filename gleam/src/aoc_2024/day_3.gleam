import gleam/int
import gleam/io
import gleam/list
import gleam/string
import utils/benchmark
import utils/quick
import utils/regex

pub fn parse(input: String) {
  // use <- benchmark.profile("Parsing")
  input
}

const do = "do()"

const dont = "don't()"

const dodont_pattern = "(?<=do\\(\\))(.+?)(?=don't\\(\\))"

const mul_pattern = "mul\\(\\d+,\\d+\\)"

pub fn pt_1(input: String) {
  input
  |> regex.regex_matches_map(mul_pattern, parse_mul)
  |> int.sum
}

pub fn pt_2(input: String) {
  let input = do <> input <> dont

  regex.regex_matches_map(input, dodont_pattern, fn(content) {
    regex.regex_matches_map(content, mul_pattern, parse_mul)
    |> int.sum
  })
  |> int.sum
}

fn parse_mul(content: String) -> Int {
  let value = string.slice(content, 4, string.length(content) - 5)
  let pair = quick.unwrap(string.split_once(value, ","))
  quick.int(pair.0) * quick.int(pair.1)
}
