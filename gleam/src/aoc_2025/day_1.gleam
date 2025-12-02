import gleam/list
import gleam/string
import utils/quick

pub type Direction {
  L
  R
}

fn split_line(value: String) {
  case value {
    "L" <> num -> #(L, quick.int(num))
    "R" <> num -> #(R, quick.int(num))
    _ -> #(R, 0)
    // not returning results because this is aoc
  }
}

pub fn parse(input: String) {
  use line <- list.map(string.split(input, "\n"))
  split_line(line)
}

pub fn pt_1(input: List(#(Direction, Int))) {
  let result =
    list.fold(input, #(50, 0), fn(acc, cur) {
      let #(pos, count) = acc
      let #(direction, amount) = cur

      let new_pos = case direction {
        R -> { pos + amount } % 100
        L -> { pos - amount } % 100
      }

      let new_count = case pos {
        0 -> count + 1
        _ -> count
      }
      #(new_pos, new_count)
    })

  result.1
}

const starting_pos = 50

const total_clicks = 100

const initial_state = #(starting_pos, 0)

pub fn pt_2(input: List(#(Direction, Int))) {
  let result =
    list.fold(input, initial_state, fn(acc, cur) {
      let #(pos, count) = acc
      let #(direction, amount) = cur

      // Add full rotations to count (not present in example input)
      let over_rotations = amount / total_clicks
      let count = count + over_rotations

      // Add partial rotations passing thru or ending on 0
      let amount = amount % total_clicks
      case direction {
        L -> {
          let new_pos = { pos - amount + total_clicks } % total_clicks

          let new_count = case pos - amount <= 0 && pos > 0 {
            True -> count + 1
            False -> count
          }

          #(new_pos, new_count)
        }
        R -> {
          let new_pos = { pos + amount } % total_clicks

          let new_count = case
            pos + amount >= total_clicks && pos < total_clicks
          {
            True -> count + 1
            False -> count
          }

          #(new_pos, new_count)
        }
      }
    })

  result.1
}
// Amazing solution by discord:kappa.23
// pub fn pt_2(input: List(#(Int, Int))) {
//   let acc =
//     input
//     |> list.fold(#(50, 0), fn(acc, rotation) {
//       let #(dial, count) = acc
//       let #(direction, amount) = rotation

//       let count = count + { { 100 + direction * dial } % 100 + amount } / 100

//       let dial = { dial + direction * amount } % 100

//       #(dial, count)
//     })

//   acc.1
// }
