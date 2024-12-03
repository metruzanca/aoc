import gleam/io
import tempo/duration

pub fn profile(label: String, fun: fn() -> a) -> a {
  let timer = duration.start_monotonic()
  let result = fun()
  let elapsed = duration.since(timer)

  io.debug(label <> ": " <> elapsed)
  result
}
