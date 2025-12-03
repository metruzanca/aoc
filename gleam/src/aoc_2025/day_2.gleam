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

// Checks if value is repeating digits/groups for the whole value e.g.
// 1 1 1, 64 64, 2 2, 33 33 33. (spaces emphasis)
// repeating at least twice but must be the whole value
// 1 1 0, while repeating the ones, it would need to be 1 1 1.
fn find_repeating_substring(value: Int) {
  let str = int.to_string(value)
  let len = string.length(str)

  let is_even = len % 2 == 0

  let max_size = case is_even {
    True -> len / 2
    False -> 1
  }

  // echo value`

  let sub_str_sizes = list.range(1, max_size) |> list.reverse

  // Split the string into as many chunks as we can

  list.any(sub_str_sizes, fn(size) {
    let chunks = list.sized_chunk(string.split(str, ""), size)

    let assert Ok(first) = list.first(chunks)

    list.all(chunks, fn(x) { string.join(first, "") == string.join(x, "") })
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

  result
}

// tried 3349553331 but was too low
// tried 50857215695 but is too high

pub fn pt_2(input: Input) {
  let all_ids =
    list.flat_map(input, fn(pair) {
      let #(a, b) = pair
      list.range(a, b)
    })

  let result =
    list.fold(all_ids, 0, fn(invalid_sum, id) {
      case find_repeating_substring(id) {
        True -> invalid_sum + id
        _ -> invalid_sum
      }
    })

  echo #(
    result == pt_2_example_answer,
    "got: ",
    result,
    "expected: ",
    pt_2_example_answer,
  )

  result
}
