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
  |> list.transpose
  // |> io.debug
  |> list.fold(0, fn(acc, cur) {
    // TODO ask Gleam discord how to cur[0] and cur[1]
    let assert Ok(left) = list.first(cur)
    let assert Ok(right) = list.last(cur)
    // io.debug(int.absolute_value(left - right))
    acc + int.absolute_value(left - right)
  })
  // |> io.debug
}

pub fn pt_2(input: String) {
  let columns = input
  |> string.split("\n")
  |> list.map(fn(line) {
    string.split(line, "   ")
  })
  |> list.transpose

  // again TODO how do you get left and right list...
    let assert Ok(left) = list.first(columns)
    let assert Ok(right) = list.last(columns)

    left
    |> list.map(fn(item) {
      let assert Ok(value) = int.parse(item)
      // TODO memoize this count, maybe?
      list.count(right, fn(r_item) {
        r_item == item
      }) * value
    })
    |> io.debug
    |> int.sum


}
