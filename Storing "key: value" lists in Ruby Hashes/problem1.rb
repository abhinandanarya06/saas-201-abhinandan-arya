# Problem 1. Given two arrays books and authors, merge them into a single Hash.
# The keys of the Hash must be the lower-cased firstname of the authors, and must be symbols.

books = ["Design as Art", "Anathem", "Shogun"]
authors = ["Bruno Munari", "Neal Stephenson", "James Clavell"]
# fill in code that will create a Hash that looks like:
#   {
#     :bruno => "Design as Art",
#     :neal => "Anathem",
#     ...
#   }

FIRST_NAME = 0

hmap = {}

authors.each.with_index { |author, i| hmap[author.split[FIRST_NAME].downcase.to_sym] = books[i] }

puts hmap
