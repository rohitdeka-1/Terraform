# Day 6: Terraform Data Types

This section demonstrates how to use different data types in Terraform across a standard multi-file project structure.

## Learning Flow

To best understand how data types work in Terraform, review the files in the following order:

1. **`provider.tf`**: Start here. This file configures the AWS provider and shows a simple use of a string variable (`var.region`).
2. **`variables.tf`**: This is the most important file for this lesson. It defines variables using various data types:
   - `string`: Simple text.
   - `number`: Numeric values.
   - `bool`: Boolean (true/false) values.
   - `list(string)`: An ordered collection of strings.
   - `map(string)`: A collection of key-value pairs.
   - `object({...})`: A complex structure allowing different types for each attribute.
   - `tuple([...])`: A fixed-size collection where each element can have a specific type.
3. **`locals.tf`**: See how variables are manipulated and combined. Notice how we access list elements (e.g., `var.availability_zones[0]`), map values, and merge maps together.
4. **`main.tf`**: See how these variables and locals are actually used to configure an AWS EC2 instance. Notice the use of `count`, the `element()` function for lists, and how attributes of the object variable are accessed (e.g., `var.server_config.ami_id`).
5. **`outputs.tf`**: Finally, see how to output complex data types (like an entire object or a list of instance IDs) to the console after running `terraform apply`.
