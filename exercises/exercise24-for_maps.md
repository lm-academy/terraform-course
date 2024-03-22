# `for` Expression with Maps

## Introduction

In this exercise, we will explore how to use `for` expressions with maps in Terraform. We will learn how to define a map, create locals that consist of modified versions of this map, and output the results. This exercise will help you understand how to work with maps, a crucial data structure in Terraform, and how to perform operations on them.

## Desired Outcome

If you wish to give it a shot before looking into the detailed step-by-step and the solution videos, here is an overview of what the created solution should deploy:

1. Create a variable `numbers_map` of type `map(number)`. This will be the map on which we operate.
2. Create a local `doubles_map`. This local consists of each key-value pair in `numbers_map`, but with each value doubled.
3. Create a local `even_map`. This local consists of each key-value pair in `numbers_map`, but only if the value is even. Each value should also be doubled.
4. Output the results of `doubles_map` and `even_map`. Running the `terraform plan` command will allow you to visualize these outputs.

## Step-by-Step Guide

1. Start by defining a variable `numbers_map` of type `map(number)`. This will be the map on which we will operate.

    ```
    variable "numbers_map" {
      type = map(number)
    }
    ```

2. Next, create a local `doubles_map`. We use a for loop to iterate over each key-value pair in `numbers_map`. For each pair, we generate a new key-value pair where the value is doubled.

    ```
    locals {
      doubles_map = { for key, value in var.numbers_map : key => value * 2 }
    }
    ```

3. Also create a local `even_map`. Again, use a for loop to iterate over each key-value pair in `numbers_map`. However, this time we only generate a new key-value pair where the value is even, and we also double the values.

    ```
    locals {
      doubles_map = { for key, value in var.numbers_map : key => value * 2 }
      even_map = { for key, value in var.numbers_map : key =>
        value * 2 if value % 2 == 0
      }
    }
    ```

4. Finally, output the results of `doubles_map` and `even_map`. Run the `terraform plan` command to visualize the outputs.

    ```
    output "doubles_map" {
      value = local.doubles_map
    }

    output "even_map" {
      value = local.even_map
    }
    ```

In the above code, the for loop in Terraform is utilized to iterate through a map and perform operations on it. The for loop is a powerful tool in Terraform that can be used to transform data structures and perform complex operations.

## Congratulations on Completing the Exercise!

Great job on completing this exercise! You've learned how to work with maps in Terraform, including how to define a map, create locals that consist of modified versions of this map, and output the results. Keep practicing these skills as they are crucial for managing infrastructure as code. Keep up the good work!
