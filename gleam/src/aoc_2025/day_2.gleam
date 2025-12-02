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

// Returns the size of the substring
fn find_repeating_substring(value: Int) {
  let str = int.to_string(value)
  let len = string.length(str)
  let max_size = len / 2

  // Iterate all the possible sizes of duplicate numbers
  let found =
    list.range(1, max_size)
    |> list.find(fn(sub_len) {
      // Check all positions with the given size
      list.range(0, len - 2 * sub_len)
      // list.any over list.find since any returns an bool
      |> list.any(fn(i) {
        let sub_str_1 = string.slice(str, i, i + sub_len)
        let sub_str_2 = string.slice(str, i + sub_len, i + 2 * sub_len)

        // is the substring is all zeros, we can skip it. 
        use <- bool.guard(string.starts_with(sub_str_1, "0"), False)

        sub_str_1 == sub_str_2
      })
    })

  found
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
        Ok(_) -> {
          echo id
          invalid_sum + id
        }
        _ -> invalid_sum
      }
    })

  echo #(result, result == pt_2_example_answer)

  result
}
