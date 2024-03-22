# Working with Functions

## Introduction

In this exercise, we will delve into the practical implementation of various functions in Terraform. We will explore how to use built-in functions to manipulate and transform data types. This includes, among others, working with string functions, mathematical computations, and file encoding and decoding functions. By the end of this exercise, you should have a firm understanding of how to utilize these functions effectively in your Terraform scripts.

## Step-by-Step Guide

1. Start by defining some local variables using the `locals` block. Declare a `name`, `age`, and `my_object`, which contain reasonable primitive and object values.

    ```
    locals {
      name = "Lauro Müller"
      age  = 15
      my_object = {
        key1 = 10
        key2 = "my_value"
      }
    }
    ```

2. Additionally, create a `users.yaml` file with the following content:

    ```
    users:
    - name: Lauro
      group: developers
    - name: John
      group: auditors
    ```

3. Create an output that uses the `startswith` function to check if the `local.name` starts with a certain value. Which functions can we use to ensure the comparison is case-insensitive?

    ```
    output "example1" {
      value = startswith(lower(local.name), "john")
    }
    ```

4. Create another output block that calculates the square of `local.age` using the `pow` function.

    ```
    output "example2" {
      value = pow(local.age, 2)
    }
    ```

5. Create a third output block that uses the `yamldecode` function to decode the created YAML file named `users.yaml` within the module's path. Output a list containing only the `name` property of each object.

    ```
    output "example3" {
      value = yamldecode(file("${path.module}/users.yaml")).users[*].name
    }
    ```

6. Finally, create a fourth output block that uses the `jsonencode` function to convert `local.my_object` into a JSON string.

    ```
    output "example4" {
      value = jsonencode(local.my_object)
    }
    ```

## Congratulations on Completing the Exercise!

Well done on completing this exercise! You've gained practical experience with various Terraform functions, advancing your skills in manipulating and transforming data types. Keep up the good work!
