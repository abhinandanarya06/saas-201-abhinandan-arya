# Problem 3. Print the given list of todos by category. (You haven't learned Hashes yet, so use only arrays.)

todos = [
  ["Send invoice", "money"],
  ["Clean room", "organize"],
  ["Pay rent", "money"],
  ["Arrange books", "organize"],
  ["Pay taxes", "money"],
  ["Buy groceries", "food"],
]

# Fill in code that will print:
#   money:
#     Send invoice
#     Pay rent
#     Pay taxes
#   organize:
#     Clean room
#     Arrange books
#   food:
#     Buy groceries

# VARIABLE FOR STORING TODOS CATEGORIES
cats = []

# GETTING CATEGORIES SET FROM TODO LIST
todos.each { |todo|
  found = cats.find { |e| e == todo[1] }
  if (found == nil)
    cats.push(todo[1])
  end
}

# VARIABLE HAVING OUTPUT TO BE PRINTED
output = []

# ITERATING OVER ALL TODO CATEGORIES
cats.each { |cat|

  # FIRST PUSH TODO CATEGORY
  output.push("  #{cat}:")

  # VARIABLE FOR STORING TODOS OF CURRENT CATEGORIES
  todol = []

  # ITERATING OVER ALL TODOS
  todos.each { |todo|
    if (cat == todo[1])
      todol.push("    #{todo[0]}")
    end
  }
  output.push(todol)
}

# PRINTING THE ANSWER
puts output
