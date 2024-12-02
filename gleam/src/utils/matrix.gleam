import gleam/list
import gleam/string

/// Shorthand type
type Matrix(a) =
  List(List(a))

/// String to List of Lists aka Matrix
pub fn parse(
  input: String,
  row_delimiter: String,
  col_delimiter: String,
) -> Matrix(String) {
  input
  |> string.split(row_delimiter)
  |> list.map(fn(line) {
    line
    |> string.split(col_delimiter)
  })
}

pub fn map_row(map matrix: Matrix(a), with func: fn(List(a)) -> b) {
  list.map(matrix, func)
}

/// Shorthand for operating on each cell of a Matrix
pub fn map_cell(map matrix: Matrix(a), with func: fn(a) -> b) {
  list.map(matrix, fn(row) { list.map(row, func) })
}
