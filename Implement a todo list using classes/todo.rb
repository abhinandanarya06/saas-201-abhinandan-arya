#                     REQUIRED OUTPUT
#
# My Todo-list
#
# Overdue
# [ ] Submit assignment 2020-01-21
#
#
# Due Today
# [X] Pay rent
# [ ] Service vehicle
#
#
# Due Later
# [ ] File taxes 2020-01-23
# [ ] Call Acme Corp. 2020-01-23

require "date"

##############------- STARTING MY CODE --------############
class Todo
  #         DEFINED TODO DATA
  # 1. @text
  # 2. @due_date
  # 3. @completed
  #
  #         DEFINED TODO BEHAIVOUR
  # 1. this.overdue?
  # 2. this.due_today?
  # 3. this.due_later?
  # 4. this.to_displayable_string
  def initialize(text, due_date, completed)
    @text = text
    @due_date = due_date
    @completed = completed
  end

  def overdue?
    @due_date < Date.today
  end

  def due_today?
    @due_date == Date.today
  end

  def due_later?
    @due_date > Date.today
  end

  def to_displayable_string
    "[#{@completed ? "X" : " "}] #{@text} #{@completed ? " " : @due_date}"
  end
end

class TodosList
  #         DEFINED TODOS LIST DATA
  # 1. @todos
  #
  #         DEFINED TODOS LIST BEHAIVOUR
  # 1. this.overdue
  # 2. this.due_today
  # 3. this.due_later
  # 4. this.to_displayable_list
  def initialize(todos)
    @todos = todos
  end

  def overdue
    TodosList.new(@todos.filter { |todo| todo.overdue? })
  end

  def due_today
    TodosList.new(@todos.filter { |todo| todo.due_today? })
  end

  def due_later
    TodosList.new(@todos.filter { |todo| todo.due_later? })
  end

  def add(new_todo)
    @todos.push(new_todo)
  end

  def to_displayable_list
    @todos.map { |todo| todo.to_displayable_string }.join("\n")
  end
end

##############------- ENDING MY CODE --------############

date = Date.today
todos = [
  { text: "Submit assignment", due_date: date - 1, completed: false },
  { text: "Pay rent", due_date: date, completed: true },
  { text: "File taxes", due_date: date + 1, completed: false },
  { text: "Call Acme Corp.", due_date: date + 1, completed: false },
]

todos = todos.map { |todo|
  Todo.new(todo[:text], todo[:due_date], todo[:completed])
}

todos_list = TodosList.new(todos)

todos_list.add(Todo.new("Service vehicle", date, false))

puts "My Todo-list\n\n"

puts "Overdue\n"
puts todos_list.overdue.to_displayable_list
puts "\n\n"

puts "Due Today\n"
puts todos_list.due_today.to_displayable_list
puts "\n\n"

puts "Due Later\n"
puts todos_list.due_later.to_displayable_list
puts "\n\n"
