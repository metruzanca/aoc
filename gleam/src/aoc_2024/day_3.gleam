import gleam/int
import gleam/io
import gleam/list
import gleam/regex
import gleam/string
import utils/benchmark
import utils/quick

pub fn parse(input: String) {
  // use <- benchmark.profile("Parsing")
  input
}

pub fn pt_1(input: String) {
  // use <- benchmark.profile("Part 1")
  regex.from_string("mul\\(\\d+,\\d+\\)")
  |> quick.unwrap
  |> regex.scan(input)
  |> list.map(fn(match) {
    string.slice(match.content, 4, string.length(match.content) - 5)
  })
  |> list.map(fn(value) {
    let pair = quick.unwrap(string.split_once(value, ","))
    quick.int(pair.0) * quick.int(pair.1)
  })
  |> int.sum
}

pub fn pt_2(input: String) {
  // use <- benchmark.profile("Part 1")
  todo
}
