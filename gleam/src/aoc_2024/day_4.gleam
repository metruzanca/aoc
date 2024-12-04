import gleam/dict
import gleam/list
import gleam/result
import gleam/string
import utils/grid.{type Grid, type Point, type Word, Point, directions}

// Written by reverse engineering solutions from:
// - https://github.com/hunkyjimpjorps
// - https://github.com/giacomocavalieri
// Otherwise, I had no idea how to approach this problem in a FP way

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
  use count, point, _ <- dict.fold(grid, 0)
  count + count_mas_words(grid, point)
}

fn count_mas_words(grid: Grid(String), pos: Point) -> Int {
  let Point(x, y) = pos
  let slash = [Point(x - 1, y - 1), Point(x, y), Point(x + 1, y + 1)]
  let back_slash = [Point(x - 1, y + 1), Point(x, y), Point(x + 1, y - 1)]

  case get_word(grid, slash), get_word(grid, back_slash) {
    Ok("MAS"), Ok("MAS")
    | Ok("SAM"), Ok("SAM")
    | Ok("SAM"), Ok("MAS")
    | Ok("MAS"), Ok("SAM")
    -> 1
    _, _ -> 0
  }
}
