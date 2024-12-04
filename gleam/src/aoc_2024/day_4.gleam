import gleam/dict.{type Dict}
import gleam/io
import gleam/list
import gleam/result
import gleam/string

// Written by reverse engineering solutions from:
// - https://github.com/hunkyjimpjorps
// - https://github.com/giacomocavalieri
// Otherwise, I had no idea how to approach this problem in a FP way

const directions = [
  // Up
  Point(1, 0),
  // Down
  Point(-1, 0),
  // Right
  Point(0, 1),
  // Left
  Point(0, -1),
  // Up-Right
  Point(1, 1),
  // Up-left
  Point(1, -1),
  // Down-Right
  Point(-1, 1),
  // Down-left
  Point(-1, -1),
]

pub type Point {
  Point(x: Int, y: Int)
}

/// A word is a list of points, which can be used to look up the letter
type Word =
  List(Point)

/// Using a Dictionary as a lookup table for data.
/// This is much better in FP, since indexing into arrays is a big anti-pattern in gleam.
/// 
/// Functionally, its not different than a 2d array.
type Grid(data) =
  Dict(Point, data)

pub fn parse(input: String) -> Grid(String) {
  use graph, line, x <- list.index_fold(string.split(input, "\n"), dict.new())
  use graph, item, y <- list.index_fold(string.to_graphemes(line), graph)
  dict.insert(graph, Point(x, y), item)
}

pub fn pt_1(grid: Grid(String)) {
  use count, point, _ <- dict.fold(grid, 0)
  count + count_words(grid, point)
}

/// Given a position in a grid, will count all valid words in all directions.
fn count_words(grid: Grid(String), pos: Point) -> Int {
  let words = word_lookups("XMAS", pos)

  use count, word <- list.fold(words, 0)
  case get_word(grid, word) {
    Ok("XMAS") -> count + 1
    Ok(_) | Error(_) -> count
  }
}

/// Builds the word from the values in the Grid using our list of Points
/// 
/// We use results, because we might be "indexing" outside of the grid,
/// as our fn word_lookups generates point lists optimistically.
/// This function is what tells us if they're valid or not.
fn get_word(grid: Grid(String), points: Word) {
  use result, point <- list.try_fold(points, "")
  use letter <- result.try(dict.get(grid, point))
  Ok(result <> letter)
}

/// Given a word and a starting position, generates a
/// list of words represented by a coordinate list.
/// 
/// This allows us to easily check the letters of the word
fn word_lookups(str: String, pos: Point) -> List(Word) {
  let chars = string.to_graphemes(str)
  use Point(x, y) <- list.map(directions)
  use _char, index <- list.index_map(chars)
  Point(pos.x + x * index, pos.y + y * index)
}

pub fn pt_2(grid: Grid(String)) {
  todo as "part 2 not implemented"
}
