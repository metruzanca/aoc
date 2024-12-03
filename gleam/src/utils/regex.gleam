import gleam/list
import gleam/regex
import utils/quick

pub type Match =
  regex.Match

pub fn regex_scan(
  match_on content: String,
  using pattern: String,
) -> List(String) {
  regex.from_string(pattern)
  |> quick.unwrap
  |> regex.scan(content)
  |> list.map(fn(match) { match.content })
}
