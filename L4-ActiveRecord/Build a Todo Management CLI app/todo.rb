require "active_record"

class Todo < ActiveRecord::Base
  # ------------------ FILTER METHODS -----------------------
  # 1. overdue
  # 2. due_today
  # 3. due_later
  scope :overdue, -> { where("due_date < ?", Date.today) }
  scope :due_today, -> { where("due_date = ?", Date.today) }
  scope :due_later, -> { where("due_date > ?", Date.today) }

  # ------------------- OBJECT METHODS ----------------------
  # 1. to_displayable_string
  def to_displayable_string
    # NOT PRINT DATE WHEN IT DUE DATE IS TODAY
    display_date = (due_date != Date.today) ? due_date : nil
    "#{id}. #{completed ? "[X]" : "[ ]"} #{todo_text} #{display_date}"
  end

  # ------------------ CLASS MODEL METHODS --------------------
  # 1. self.show_list
  # 2. self.add_task
  # 3. self.mark_as_complete!
  def self.show_list
    puts "My Todo-list"

    puts "\nOverdue"
    puts overdue.map { |todo| todo.to_displayable_string }

    puts "\nDue Today"
    puts due_today.map { |todo| todo.to_displayable_string }

    puts "\nDue Later"
    puts due_later.map { |todo| todo.to_displayable_string }
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
