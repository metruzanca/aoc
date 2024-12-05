import gleam/int
import gleam/list
import gleam/regexp
import gleam/string
import utils/quick

const dodont_pattern = "do\\(\\)((.|\n)+?)don't\\(\\)"

const mul_pattern = "mul\\(\\d+,\\d+\\)"

pub fn parse(input: String) {
  "do()" <> input <> "don't()"
}

pub fn pt_1(input: String) {
  input
  |> regex_scan(mul_pattern)
  |> list.map(parse_mul)
  |> int.sum
}

pub fn pt_2(input: String) {
  input
  |> regex_scan(dodont_pattern)
  |> list.map(pt_1)
  |> int.sum
}

fn parse_mul(content: String) -> Int {
  let value = string.slice(content, 4, string.length(content) - 5)
  let pair = quick.unwrap(string.split_once(value, ","))
  quick.int(pair.0) * quick.int(pair.1)
}

pub fn regex_scan(
  match_on content: String,
  using pattern: String,
) -> List(String) {
  regexp.from_string(pattern)
  |> quick.unwrap
  |> regexp.scan(content)
  |> list.map(fn(match) { match.content })
}
