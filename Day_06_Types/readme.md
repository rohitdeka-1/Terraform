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

## Variables (`vars`) vs Locals (`locals`)

The difference between variables and locals comes down to **who provides the value** and **whether the value needs to be dynamically calculated**.

### 1. Variables (`vars`)

**Use variables for values that come from OUTSIDE the module.**
Think of variables as function arguments or user inputs. If someone else (or a CI/CD pipeline) using your Terraform code might need to change a value, it belongs in a variable.

- **Customization:** Things that differ between environments (e.g., `instance_count = 2` for Dev, but `10` for Prod).
- **Secrets / Credentials:** Values that shouldn't be hardcoded (e.g., database passwords).
- **Examples in this project:** `region`, `enable_monitoring`, `common_tags`. You want the person deploying the infrastructure to be able to override these.

### 2. Locals (`locals`)

**Use locals for values computed INSIDE the module.**
Think of locals as internal helper variables. If a value is derived from combining variables, or is a static standard used multiple times across your resources, it belongs in a local block. Users deploying your code cannot override a local.

- **Avoiding Repetition:** If you are using the same complex expression multiple times (like combining project name and environment to make a standard prefix), put it in a local.
- **Transforming Data:** If you take a variable and need to modify it before using it (e.g., ensuring a string is lowercase, or merging default tags with user-provided tags).
- **Examples in this project:**
  - `name_prefix` — You wouldn't ask a user to type this prefix out if they've already given you the Project and Environment tags.
  - `merged_tags` — Automatically injects mandatory internal tags (like `ManagedBy = "Terraform"`) alongside user-provided tags.

**Summary Rule of Thumb:**
- If the user running `terraform apply` needs to define it, use a **Variable**.
- If your code calculates it to keep things clean and DRY (Don't Repeat Yourself), use a **Local**.
