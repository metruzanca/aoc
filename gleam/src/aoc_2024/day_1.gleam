import gleam/int
import gleam/list
import utils/matrix
import utils/quick

pub fn parse(input: String) {
  input
  |> matrix.row("\n")
  |> matrix.col("   ")
  |> matrix.map_cell(quick.int)
}

// TODO to remove left,right, use tuple of lists instead!
// Then see if possible to remove the transpose |> map |> transpose

pub fn pt_1(input: List(List(Int))) {
  input
  |> list.transpose
  |> list.map(fn(col) { list.sort(col, by: int.compare) })
  |> list.transpose
  |> list.fold(0, fn(acc, cur) {
    let assert Ok(left) = list.first(cur)
    let assert Ok(right) = list.last(cur)
    acc + int.absolute_value(left - right)
  })
}

pub fn pt_2(columns: List(List(Int))) {
  let columns = list.transpose(columns)
  let assert Ok(left) = list.first(columns)
  let assert Ok(right) = list.last(columns)

  left
  |> list.map(fn(item) {
    list.count(right, fn(r_item) { r_item == item }) * item
  })
  |> int.sum
}
