import gleam/bool
import gleam/int
import gleam/list
import gleam/string
import utils/quick

type Input =
  List(#(Int, Int))

pub fn parse(input: String) -> Input {
  use line <- list.map(string.split(input, ","))
  let assert Ok(#(a, b)) = string.split_once(line, "-")
  #(quick.int(a), quick.int(b))
}

const pt_1_example_answer = 1_227_775_554

const pt_2_example_answer = 4_174_379_265

// Checks if theres substring of repeating digits (excluding 0) or groups of digits
// 111 is repeating 1s. 6464 is repeating 64
fn find_repeating_substring(value: Int) {
  let str = int.to_string(value)
  let len = string.length(str)
  let max_size = len / 2

  let sub_str_sizes = list.range(1, max_size)

  list.any(sub_str_sizes, fn(size) {
    let sub_str_1 = string.slice(str, 0, size)
    let sub_str_2 = string.slice(str, size, size * 2)

    use <- bool.guard(
      string.length(sub_str_1) == string.length(sub_str_2),
      sub_str_1 == sub_str_2,
    )

    // echo #(str, size, max_size, sub_str_1, sub_str_2)

    let sub_str_2 = string.slice(str, size, size * 2 - 1)

    sub_str_1 == sub_str_2
  })
}

// Returns the size of the substring
fn is_repeating_pair(value: Int) {
  let str = int.to_string(value)
  let len = string.length(str)
  let half = len / 2

  let first = string.slice(str, 0, half)
  let last = string.slice(str, half, len)

  first == last
}

pub fn pt_1(input: Input) {
  let all_ids =
    list.flat_map(input, fn(pair) {
      let #(a, b) = pair
      list.range(a, b)
    })

  let result =
    list.fold(all_ids, 0, fn(invalid_sum, id) {
      case is_repeating_pair(id) {
        True -> {
          invalid_sum + id
        }
        _ -> invalid_sum
      }
    })

  echo #(result, result == pt_1_example_answer)

  result
}

// tried 3349553331 but was too low

pub fn pt_2(input: Input) {
  let all_ids =
    list.flat_map(input, fn(pair) {
      let #(a, b) = pair
      list.range(a, b)
    })

  let result =
    list.fold(all_ids, 0, fn(invalid_sum, id) {
      case find_repeating_substring(id) {
        True -> {
          echo id
          invalid_sum + id
        }
        _ -> invalid_sum
      }
    })

  echo #(result, result == pt_2_example_answer)

  result
}
