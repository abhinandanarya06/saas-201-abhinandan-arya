require "active_record"

class Todo < ActiveRecord::Base
  # ------------------- OBJECT METHODS ----------------------
  # 1. overdue?
  # 2. due_today?
  # 3. due_later?
  # 4. to_displayable_string

  def overdue?
    due_date < Date.today
  end

  def due_today?
    due_date == Date.today
  end

  def due_later?
    due_date > Date.today
  end

  def to_displayable_string
    display_date = due_today? ? nil : due_date
    "#{completed ? "[X]" : "[ ]"} #{todo_text} #{display_date}"
  end

  # ------------------ CLASS MODEL METHODS --------------------
  # 1. self.show_list
  # 2. self.add_task
  # 3. self.mark_as_complete!
  def self.show_list
    puts "My Todo-list"

    puts "\nOverdue"
    puts all.filter { |todo| todo.overdue? }.map { |todo|
      "#{todo.id}. [#{todo.completed ? "X" : " "}] #{todo.todo_text} #{todo.due_date}"
    }

    puts "\nDue Today"
    puts all.filter { |todo| todo.due_today? }.map { |todo|
      "#{todo.id}. [#{todo.completed ? "X" : " "}] #{todo.todo_text}"
    }

    puts "\nDue Later"
    puts all.filter { |todo| todo.due_later? }.map { |todo|
      "#{todo.id}. [#{todo.completed ? "X" : " "}] #{todo.todo_text} #{todo.due_date}"
    }
  end

  def self.add_task(new_todo)
    create!(todo_text: new_todo[:todo_text],
            due_date: Date.today + new_todo[:due_in_days],
            completed: false)
  end

  def self.mark_as_complete!(todo_id)
    todo = find(todo_id)
    todo.completed = true
    todo.save
    todo
  end
end
