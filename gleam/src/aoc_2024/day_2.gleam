import gleam/list
import utils

pub fn parse(input: String) {
  utils.list_of_lists(input, "\n", " ")
}

pub fn pt_1(input: List(List(Int))) {
  list.count(input, safe)
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

pub fn pt_2(input: List(List(Int))) {
  todo as "aaaa"
}
