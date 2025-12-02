import gleam/int
import gleam/io
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
        R -> { pos - amount } % 100
        L -> { pos + amount } % 100
      }

      let new_count = case pos {
        0 -> count + 1
        _ -> count
      }
      #(new_pos, new_count)
    })

  result.1
}

pub fn pt_2(input: List(#(Direction, Int))) {
  let result =
    list.fold(input, #(50, 0), fn(acc, value) {
      let #(pos, count) = acc
      let #(direction, amount) = value

      let new_pos = case direction {
        R -> pos - amount
        L -> pos + amount
      }

      echo [pos, amount, new_pos]

      io.println("Final pos: " <> int.to_string(pos))

      #(
        new_pos % 100,
        // Account for passing the 0 by doing an int divide
        count + { new_pos / 100 },
      )
    })

  result.1
}
