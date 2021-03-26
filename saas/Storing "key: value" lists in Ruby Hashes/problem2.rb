# Problem 2. Given this list of todos, create a Hash keyed by category,
# whose value is an array containing all the todos in that category.
# The keys of the Hash must be a symbol.

todos = [
  ["Send invoice", "money"],
  ["Clean room", "organize"],
  ["Pay rent", "money"],
  ["Arrange books", "organize"],
  ["Pay taxes", "money"],
  ["Buy groceries", "food"],
]

# Fill in code that will create a Hash that looks like:
#   {
#     :money =>
#       ["Send invoice", "Pay rent", ...],
#     ...
#   }

hmap = {}
todos.each { |todo|
  exist = hmap.keys.find { |e| e == todo[1].to_sym }
  if (exist == nil)
    hmap[todo[1].to_sym] = []
  end
  hmap[todo[1].to_sym].push(todo[0])
}

puts hmap
