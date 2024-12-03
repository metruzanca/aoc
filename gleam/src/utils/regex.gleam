import gleam/list
import gleam/regexp
import utils/quick

pub type Match =
  regexp.Match

pub fn regex_scan(
  match_on content: String,
  using pattern: String,
) -> List(String) {
  regexp.from_string(pattern)
  |> quick.unwrap
  |> regexp.scan(content)
  |> list.map(fn(match) { match.content })
}
