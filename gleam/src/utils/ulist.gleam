import gleam/list
import gleam/string

/// Removes value at index and returns new list
pub fn remove_at(list: List(Int), at index: Int) {
  list.append(list.take(list, index), list.drop(list, index + 1))
}

/// Parse input into a list-list
pub fn list_list(input: String, row_delimiter: String, col_delimiter: String) {
  input
  |> string.split(row_delimiter)
  |> list.map(fn(line) { string.split(line, col_delimiter) })
}

/// Parse input into a tuple-list
pub fn tuple_list(input: String, row_delimiter: String, col_delimiter: String) {
  input
  |> string.split(row_delimiter)
  |> list.map(fn(line) {
    let assert Ok(pair) = string.split_once(line, col_delimiter)
    pair
  })
}

/// Shorthand for operating on each cell of a list-list
pub fn map_cell(map list_list: List(List(a)), with func: fn(a) -> b) {
  list.map(list_list, fn(row) { list.map(row, func) })
}

/// Shorthand for operating on each of the pairs of a tuple-list
pub fn map_tuple_cell(map tuple_list: List(#(a, a)), with func: fn(a) -> b) {
  list.map(tuple_list, fn(tuple) { #(func(tuple.0), func(tuple.1)) })
}
