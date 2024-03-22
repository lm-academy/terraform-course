# `for` Expression with Lists

## Introduction

In this exercise, we will learn how to manipulate and analyze data in lists using Terraform. We will work with numerical lists and lists of objects, and create new lists with specific characteristics. This exercise will enrich your understanding of Terraform's powerful list manipulation capabilities and help you utilize them in your own projects. So let's get started!

## Desired Outcome

If you wish to give it a shot before looking into the detailed step-by-step and the solution videos, here is an overview of what the created solution should deploy:

1. Create two variables, `numbers_list` and `objects_list`. The type of `numbers_list` is a list of numbers, and the type of `objects_list` is a list of objects, each containing `firstname` and `lastname` properties as strings.
2. Create a local named `double_numbers` is created. This local contains a list of numbers from `numbers_list`, each doubled.
3. Create a local named `even_numbers` is created. This local contains a list of only the even numbers from `numbers_list`.
4. Create a local named `firstnames` is created. This local contains a list of all the first names from `objects_list`.
5. Create a local named `fullnames` is created. This local contains a list of concatenated first and last names from `objects_list`.

## Step-by-Step Guide

1. Start by defining two variables, `numbers_list` and `objects_list`. The type of `numbers_list` is a list of numbers, and the type of `objects_list` is a list of objects, each containing `firstname` and `lastname` properties as strings.

    ```
    variable "numbers_list" {
      type = list(number)
    }

    variable "objects_list" {
      type = list(object({
        firstname = string
        lastname  = string
      }))
    }
    ```

2. Create a `local.double_numbers` entry, which iterates over the variable `numbers_list` and creates a new list containing the doubled values of all its elements.

    ```
    locals {
      double_numbers = [for num in var.numbers_list : num * 2]
    }
    ```

3. Now create a `local.even_numbers` entry, which iterates over the variable `numbers_list` and creates a new list containing only its even numbers.

    ```
    locals {
      double_numbers = [for num in var.numbers_list : num * 2]
      even_numbers   = [for num in var.numbers_list : num if num % 2 == 0]
    }
    ```

4. Now create a `local.firstnames` entry, which iterates over the variable `objects_list` and creates a new list containing only the value of each element’s `firstname` property.

    ```
    locals {
      double_numbers = [for num in var.numbers_list : num * 2]
      even_numbers   = [for num in var.numbers_list : num if num % 2 == 0]
      firstnames     = [for person in var.objects_list : person.firstname]
    }
    ```

5. Last but not least, create a `local.fullnames` entry, which iterates over the variable `objects_list` and creates a new list containing the concatenated value of the `firstname` and `lastname` properties.

    ```
    locals {
      double_numbers = [for num in var.numbers_list : num * 2]
      even_numbers   = [for num in var.numbers_list : num if num % 2 == 0]
      firstnames     = [for person in var.objects_list : person.firstname]
      fullnames = [
        for person in var.objects_list : "${person.firstname} ${person.lastname}"
      ]
    }
    ```

6. Output the values from the locals block by using outputs, and visualize the results by running `terraform plan`.

    ```
    output "double_numbers" {
      value = local.double_numbers
    }

    output "even_numbers" {
      value = local.even_numbers
    }

    output "firstnames" {
      value = local.firstnames
    }

    output "fullnames" {
      value = local.fullnames
    }
    ```

## Congratulations on Completing the Exercise!

Great job on completing this exercise! Your ability to manipulate and analyze data in lists using Terraform has improved considerably! Keep up the good work and continue to enhance your skills in Terraform. Keep practicing and happy learning!
