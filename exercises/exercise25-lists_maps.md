# Transforming Lists into Maps and Vice Versa

## Introduction

In this exercise, we will explore how to transform lists into maps and vice versa in Terraform. This knowledge will be crucial in managing complex data structures and efficiently retrieving and manipulating data. The exercise is broken down into detailed steps that walk you through the process of creating a `users` list variable, transforming this list into a `users_map`, and then transforming that map back into a list. By the end of the exercise, you should have a good understanding of how to work with lists and maps in Terraform.

## Desired Outcome

If you wish to give it a shot before looking into the detailed step-by-step and the solution videos, here is an overview of what the created solution should deploy:

1. Create a `users` variable, which receives a list of objects, with each object containing a `username` and `role` properties.
2. Create a `users_map` local, which transforms the `var.users` list into a map where the `username` property becomes the key in the map, and the `role` property becomes the value.
    1. The `users_map` local should also handle duplicated usernames and return a list of roles whenever a username appears more than once in the `users` variable.
3. Create a `users_map2` local, which transforms our `local.users_map` into a new map with the following structure: `<key> => { roles = <roles list> }`.
4. Create a `user_to_output` variable, which receives a string used to retrieve a specific user’s information from our `users_map2` local.
5. Create a `usernames_from_map` local, which transforms the `local.users_map` map into a list containing only the username of each map entry.
6. Define outputs to visualize the information we have been processing so far.

## Step-by-Step Guide

1. First, define a variable named `users`, which is of type list of objects, each object containing a `username` and `role` properties.

    ```
    variable "users" {
      type = list(object({
        username = string
        role     = string
      }))
    }
    ```

2. Now create a local `users_map`, which transforms the `var.users` list into a map where the `username` property becomes the key in the map, and the `role` property becomes the value. What happens when we have more than one entry in the list containing the same username?

    ```
    locals {
      users_map = {
        for user_info in var.users : user_info.username => user_info.role
      }
    }
    ```

3. Having a duplicated key will throw an error. Use the ellipsis operator at the end of `user_info.role` to group together all the roles for a single `username` under the same map key.

    ```
    locals {
      users_map = {
        for user_info in var.users : user_info.username => user_info.role...
      }
    }
    ```

4. Now create a new local which transforms our `local.users_map` into a new map with the following structure: `<key> => { roles = <roles list> }`

    ```
    locals {
      users_map2 = {
        for username, roles in local.users_map : username => {
          roles = roles
        }
      }
    }
    ```

5. Create a variable `user_to_output`, which is of type string. This variable will be used to retrieve a specific user’s information from our `users_map2` local.

    ```
    variable "user_to_output" {
      type = string
    }
    ```

6. Define a couple of outputs that allow us to visualize the information we have been processing so far. Run a `terraform plan` to visualize the changes.

    ```
    output "users_map" {
      value = local.users_map
    }

    output "users_map2" {
      value = local.users_map2
    }

    output "user_to_output_roles" {
      value = local.users_map2[var.user_to_output].roles
    }
    ```

7. Last but not least, create a local that transforms the `local.users_map` map into a list containing only the username of each map entry. Create a new output to show the information and run a `terraform plan` to visualize the results.

    ```
    locals = {
      usernames_from_map = [for username, roles in local.users_map : username]
      # We can also use usernames_from_map = keys(local.users_map) instead of manually creating the list!
    }

    output "usernames_from_map" {
      value = local.usernames_from_map
    }
    ```

## Congratulations on Completing the Exercise!

Great job on completing this challenging exercise! You've worked hard and learned how to transform lists into maps, and maps into lists in Terraform. This skill will be immensely beneficial in managing complex data structures and retrieving and manipulating data efficiently. Keep practicing and continue to expand your knowledge. Keep up the good work!
