import gleam/int
import gleam/list
import gleam/string
import utils/quick
import utils/ulist

pub fn parse(input: String) {
  use line <- list.map(string.split(input, "\n"))
  line
  |> string.to_graphemes
  |> list.map(quick.int)
}

pub fn pt_1(input: List(List(Int))) {
  input
  |> list.map(max_joltage)
  |> int.sum
}

fn max_joltage(bank: List(Int)) {
  bank
  |> list.combinations(2)
  |> list.fold(-1, fn(acc, combination) {
    let current = digits_to_number(combination)

    case current > acc {
      True -> current
      False -> acc
    }
  })
}

fn digits_to_number(digits: List(Int)) {
  list.fold(digits, 0, fn(acc, cur) { acc * 10 + cur })
}

pub fn pt_2(input: String) {
  todo as "part 2 not implemented"
}
