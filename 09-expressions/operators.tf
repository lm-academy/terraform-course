locals {
  math       = 2 * 2  # Math operators: *, /, +, -, -<number>
  equality   = 2 != 2 # Equality operators: ==, !=
  comparison = 2 < 1  # Comparison operators: <, <=, >, >=
  logical    = true || false
}

output "operators" {
  value = {
    math       = local.math
    equality   = local.equality
    comparison = local.comparison
    logical    = local.logical
  }
}