# Level 2 : Level Up Problem

## Write a recursive DNS resolver

### Solution File

- `lookup.rb`
- `zone`

### Usage

`Usage: ruby lookup.rb <domain>`

Example Usage :

1. `$ ruby lookup.rb google.com`

   - google.com => 172.217.163.46

2. `$ ruby lookup.rb gmail.com`

   - gmail.com => mail.google.com => google.com => 172.217.163.46

3. `$ ruby lookup.rb gmil.com`
   - Error: record not found for gmil.com
