import gleam/int
import gleam/io
import gleam/list
import gleam/string
import utils/quick
import utils/regex

const dodont_pattern = "do\\(\\)(.+?)don't\\(\\)"

const mul_pattern = "mul\\(\\d+,\\d+\\)"

pub fn parse(input: String) {
  "do()" <> input <> "don't()"
}

pub fn pt_1(input: String) {
  input
  |> regex.regex_scan(mul_pattern)
  |> list.map(parse_mul)
  |> int.sum
}

pub fn pt_2(input: String) {
  input
  |> regex.regex_scan(dodont_pattern)
  |> io.debug
  |> list.flat_map(fn(content) { regex.regex_scan(content, mul_pattern) })
  |> io.debug
  |> list.map(parse_mul)
  |> int.sum
}

fn parse_mul(content: String) -> Int {
  let value = string.slice(content, 4, string.length(content) - 5)
  let pair = quick.unwrap(string.split_once(value, ","))
  quick.int(pair.0) * quick.int(pair.1)
}
