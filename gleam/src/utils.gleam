import gleam/int

pub fn is_number(x: String) -> Bool {
  case int.parse(x) {
    Ok(_) -> True
    Error(_) -> False
  }
}
