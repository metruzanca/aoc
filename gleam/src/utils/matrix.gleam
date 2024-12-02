import gleam/list
import gleam/string

/// Shorthand type
type Matrix(a) =
  List(List(a))

pub fn row(input: String, row_delimiter: String) {
  string.split(input, row_delimiter)
}

pub fn col(row: List(String), col_delimiter: String) {
  list.map(row, fn(line) { string.split(line, col_delimiter) })
}

pub fn col_tuple(row: List(String), col_delimiter: String) {
  list.map(row, fn(line) {
    let assert Ok(pair) = string.split_once(line, col_delimiter)
    pair
  })
}

pub fn map_row(map matrix: Matrix(a), with func: fn(List(a)) -> b) {
  list.map(matrix, func)
}

/// Shorthand for operating on each cell of a Matrix
pub fn map_cell(map matrix: Matrix(a), with func: fn(a) -> b) {
  list.map(matrix, fn(row) { list.map(row, func) })
}
