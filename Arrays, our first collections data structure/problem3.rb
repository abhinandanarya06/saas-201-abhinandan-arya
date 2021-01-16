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

cats = todos.map { |todo| todo[1] }.uniq
output = []

cats.each { |cat|
  output.push("  #{cat}:")

  todol = todos.filter { |todo| todo[1] == cat }.map { |todo| "    #{todo[0]}" }
  output.push(todol)
}

puts output
