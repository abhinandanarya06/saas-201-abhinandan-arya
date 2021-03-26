# Level 3 : Level Up Problem

## Implement a todo list using classes

### Demo Output

```
My Todo-list

Overdue
[ ] Submit assignment 2020-01-21


Due Today
[X] Pay rent
[ ] Service vehicle


Due Later
[ ] File taxes 2020-01-23
[ ] Call Acme Corp. 2020-01-23
```

## Classes Defined in `todo.rb`

1. **Todo**

- Data Defined

  - `@text`
  - `@due_date`
  - `@completed`

- Behaivour Defined
  - `this.overdue?`
  - `this.due_today?`
  - `this.due_later?`
  - `this.to_displayable_string`

---

2. **TodosList**

- Data Defined

  - `@todos`

- Behaivour Defined
  - `this.overdue`
  - `this.due_today`
  - `this.due_later`
  - `this.to_displayable_list`
