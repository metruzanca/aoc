import gleam/list
import gleam/string

type Matrix(a) =
  List(List(a))

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

pub fn map(mat: Matrix(a), with func: fn(List(a)) -> b) {
  list.map(mat, func)
}

pub fn map_cell(mat: Matrix(a), with func: fn(a) -> b) {
  list.map(mat, fn(row) { list.map(row, func) })
}
