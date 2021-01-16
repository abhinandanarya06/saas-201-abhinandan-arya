# Level 4 : Level Up Problem

## Build a Todo Management CLI app

### Solution Files

1. `todo.rb`
2. `connect_db.rb`
3. `list-todos.rb`
4. `add-todo.rb`
5. `complete-todo.rb`

### `todo.rb`

Implemented the class Todo so that other files depend on it can run

- `Todo class < ActiveRecord::Base`
  - Object Methods
    - `overdue?`
    - `due_today?`
    - `due_later?`
  - Class Model Methods
    - `self.show_list`
    - `self.add_task(new_todo)`
    - `self.mark_as_complete!(todo_id)`

### `connect_db.rb`

Program to connect to Postgree database

### `list-todos.rb`

```
                  Demo Output
My Todo-list

Overdue
24. [X] Submit assignment 2020-02-03


Due Today
25. [X] Pay rent
28. [ ] Service vehicle


Due Later
26. [ ] File taxes 2020-02-05
27. [ ] Call Acme Corp. 2020-02-05
```

### `add-todo.rb`

```
Usage: $ ruby add-todo.rb
```

then enter following as asked

```
Todo text:
<ENTER NEW TODO TEXT>

How many days from now is it due? (give an integer value)
<ENTER THE NUMBER OF DAYS FROM NOW>

New todo created with id <CURRENT ADDED TODO ID>

<LIST ALL ALL TODOS>
```

Example :

```
Todo text:
Document code

How many days from now is it due? (give an integer value)
3

New todo created with id 29

My Todo-list

Overdue
24. [X] Submit assignment 2020-02-03


Due Today
25. [X] Pay rent
28. [ ] Service vehicle


Due Later
26. [ ] File taxes 2020-02-05
27. [ ] Call Acme Corp. 2020-02-05
29. [ ] Document code 2020-02-06
```

### `complete-todo.rb`

```
Usage : $ ruby complete-todo.rb
```

then enter the following as asked

```
<LIST OF ALL TODOS>

Which todo do you want to mark as complete? (Enter id):
<ENTER THE TODO ID YOU WANT TO MARK>

<YOUR MARKED TODO>
```

Example :

```
My Todo-list

Overdue
24. [X] Submit assignment 2020-02-03


Due Today
25. [X] Pay rent
28. [ ] Service vehicle


Due Later
26. [ ] File taxes 2020-02-05
27. [ ] Call Acme Corp. 2020-02-05
29. [ ] Document code 2020-02-06

Which todo do you want to mark as complete? (Enter id):
29

29. [X] Document code 2020-02-06
```
