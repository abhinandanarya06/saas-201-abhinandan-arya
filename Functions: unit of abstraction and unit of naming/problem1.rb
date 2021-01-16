# Problem 1. Fill-in the following code

def salute(name, sal)
  "#{sal.capitalize} Mr. #{name.split[2]}"
end

puts salute("Nelson Rolihlahla Mandela", "hello")
puts salute("Sir Alan Turing", "welcome")

# write code so the program prints:
#   Hello Mr. Mandela
#   Welcome Mr. Turing
