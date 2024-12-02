import gleam/int
import gleam/list
import gleam/string

pub fn is_number(x: String) -> Bool {
  case int.parse(x) {
    Ok(_) -> True
    Error(_) -> False
  }
}

pub fn list_of_lists(
  input: String,
  row_delimiter: String,
  col_delimiter: String,
) {
  input
  |> string.split(row_delimiter)
  |> list.map(fn(line) {
    line
    |> string.split(col_delimiter)
    // TODO don't like how this parses to int here.
    |> list.filter_map(int.parse)
  })
}
