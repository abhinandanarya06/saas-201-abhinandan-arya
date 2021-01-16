# Problem 1. Given a nested array of first names and last names, return a new array with the full names.

names = [["Jhumpa", "Lahiri"], ["J. K", "Rowling"], ["Devdutt", "Pattanaik"]]
# fill in code that will return a new array of the full names:
#   ["Jhumpa Lahiri", "J.K Rowling", ...]

new_names = names.map { |name| "#{name[0]} #{name[1]}" }

puts new_names
