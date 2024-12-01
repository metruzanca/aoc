import gleam/int
import gleam/list
import gleam/io
import gleam/string

pub fn pt_1(input: String) {
  input
  |> string.split("\n")
  |> list.map(fn(line) {
    string.split(line, "   ")
  })
  |> list.transpose
  |> list.map(fn(col) {
    col
    |> list.filter_map(int.parse)
    |> list.sort(by: int.compare)
  })
  |> list.fold(0, fn(acc, cur) {
    // TODO ask Gleam discord how to cur[0] and cur[1]
    let assert Ok(left) = list.first(cur)
    let assert Ok(right) = list.last(cur)
  
    acc + int.absolute_value(left - right)
  })
  |> io.debug
}

pub fn pt_2(input: String) {
  todo as "part 2 not implemented"
}
