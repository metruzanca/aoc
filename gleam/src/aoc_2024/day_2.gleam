import gleam/list
import gleam/string
import utils/quick
import utils/ulist

pub fn parse(input: String) {
  use line <- list.map(string.split(input, "\n"))
  string.split(line, " ")
  |> list.map(quick.int)
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
  |> list.index_map(fn(_, idx) { ulist.remove_at(nums, idx) })
  |> list.any(safe)
}
