import simplifile

pub fn input(day: String) {
  let filepath = "../.inputs/" <> day <>".txt"
  let assert Ok(lines) = simplifile.read(filepath)
  lines
}