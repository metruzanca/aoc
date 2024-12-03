import gleam/list
import gleam/regex
import utils/quick

pub fn regex_matches(
  match_on content: String,
  using pattern: String,
  with fun: fn(List(regex.Match)) -> a,
) {
  regex.from_string(pattern)
  |> quick.unwrap
  |> regex.scan(content)
  |> fun
}

pub type Match =
  regex.Match

pub fn regex_matches_map(
  match_on content: String,
  using pattern: String,
  with fun: fn(String) -> a,
) {
  regex.from_string(pattern)
  |> quick.unwrap
  |> regex.scan(content)
  |> list.map(fn(match) { fun(match.content) })
}
