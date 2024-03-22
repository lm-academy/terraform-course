# Operators in Terraform

## Introduction

In this exercise, we will explore the different operators available in Terraform. This exercise includes working with mathematical, equality, comparison, and logical operators. You will get a chance to play around with these operators and observe their behavior, which will give you a solid foundation for writing more complex Terraform configurations in the future. Let's get started!

## Step-by-Step Guide

1. Create a locals block and play around with the math operators available in Terraform: `*, /, +, -, -<number>`. Their behavior is fairly straightforward, so there isn’t much to explore here.
2. Try the equality operators `==` and `!=`, which can be used to check whether two values are equal or not.
3. Comparison operators are also available: `<, <=, >, >=`. Give it a try!
4. Last but not least, play around with the logical operators `&&`, `||`, and `!`.

    ```
    locals {
      math       = 2 * 2
      equality   = 2 != 2
      comparison = 2 < 1
      logical    = true || false
    }
    ```

5. You can also output the values of these locals to inspect how they look like. Create an `output “operators”` block and run the `terraform plan` command to inspect the results.

    ```
    output "operators" {
      value = {
        math       = local.math
        equality   = local.equality
        comparison = local.comparison
        logical    = local.logical
      }
    }
    ```

## Congratulations on Completing the Exercise!

Great job on completing this exercise! You've taken another step in mastering Terraform operators. Keep practicing and continue to develop your skills. Remember that learning is a journey, not a destination. Keep up the good work!
