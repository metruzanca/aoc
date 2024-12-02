import gleam/list
import utils/matrix
import utils/quick

pub fn parse(input: String) {
  input
  |> matrix.parse("\n", " ")
  |> matrix.map_cell(quick.int)
}

pub fn pt_1(input: List(List(Int))) {
  list.count(input, safe)
}

pub fn pt_2(input: List(List(Int))) {
  list.count(input, fuzzy_safe)
}

fn safe(nums: List(Int)) {
  nums
  |> list.window_by_2
  |> list.map(fn(pair) { pair.0 - pair.1 })
  |> fn(row) {
    list.all(row, fn(value) { value >= 1 && value <= 3 })
    || list.all(row, fn(value) { value <= -1 && value >= -3 })
  }
}

fn fuzzy_safe(nums: List(Int)) {
  nums
  // Create every version of the row with 1 value removed
  |> list.index_map(fn(_, idx) {
    list.append(list.take(nums, idx), list.drop(nums, idx + 1))
  })
  |> list.any(safe)
}
