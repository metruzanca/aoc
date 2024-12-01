import gleam/int
import gleam/list
import gleam/string

pub fn parse(input: String) {
input
  |> string.split("\n")
  |> list.map(fn(line) {
    string.split(line, "   ")
    |> list.filter_map(int.parse)
  })
  |> list.transpose
}

// TODO to remove left,right, use tuple of lists instead!

pub fn pt_1(input: List(List(Int))) {
  input
  |> list.map(fn(col) {
    list.sort(col, by: int.compare)
  })
  |> list.transpose
  |> list.fold(0, fn(acc, cur) {
    let assert Ok(left) = list.first(cur)
    let assert Ok(right) = list.last(cur)
    acc + int.absolute_value(left - right)
  })
}

pub fn pt_2(columns: List(List(Int))) {
    let assert Ok(left) = list.first(columns)
    let assert Ok(right) = list.last(columns)

    left
    |> list.map(fn(item) {
      list.count(right, fn(r_item) { r_item == item }) * item
    })
    |> int.sum
}

