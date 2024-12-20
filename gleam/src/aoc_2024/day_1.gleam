import gleam/int
import gleam/list
import gleam/string
import utils/quick

pub fn parse(input: String) {
  use lines <- list.map(string.split(input, "\n"))
  string.split(lines, "   ")
  |> list.map(quick.int)
}

// TODO to remove left,right, use tuple of lists instead!
// Then see if possible to remove the transpose |> map |> transpose

pub fn pt_1(input: List(List(Int))) {
  input
  |> list.transpose
  |> list.map(fn(col) { list.sort(col, by: int.compare) })
  |> list.transpose
  |> list.fold(0, fn(acc, cur) {
    let assert [left, right] = cur
    acc + int.absolute_value(left - right)
  })
}

pub fn pt_2(columns: List(List(Int))) {
  let columns = list.transpose(columns)
  let assert [left, right] = columns

  use count, item <- list.fold(left, 0)
  count + list.count(right, fn(r_item) { r_item == item }) * item
}
