#                 DNS RESOLVER
#
# Usage : ```Usage: ruby lookup.rb <domain>```
#
# Example Usage :
# ```$ ruby lookup.rb google.com```
#     google.com => 172.217.163.46
#
# ```$ ruby lookup.rb gmail.com```
#     gmail.com => mail.google.com => google.com => 172.217.163.46
#
# ```$ ruby lookup.rb gmil.com```
#     Error: record not found for gmil.com

def get_command_line_argument
  # ARGV is an array that Ruby defines for us,
  # which contains all the arguments we passed to it
  # when invoking the script from the command line.
  # https://docs.ruby-lang.org/en/2.4.0/ARGF.html
  if ARGV.empty?
    puts "Usage: ruby lookup.rb <domain>"
    exit
  end
  ARGV.first
end

# `domain` contains the domain name we have to look up.
domain = get_command_line_argument

# File.readlines reads a file and returns an
# array of string, where each element is a line
# https://www.rubydoc.info/stdlib/core/IO:readlines
dns_raw = File.readlines("zone")

# ........................
# ........................
# FILL YOUR CODE HERE

# SOME CONVENTION TO BE USED
RECTYPE = 0
SOURCE = 1
DESTINATION = 2

# parse_dns(file_raw) : returns hashmap of domain to domain and domain to ip mapping

def parse_dns(raw)
  # HASHMAP FROM SOURCE TO DESTINATION MAPPING
  records = {}

  raw.each { |line|

    # IF line IS VALID RECORD
    if not(line.strip[0] == "#" or line.strip.length == 0)

      # SPLIT THE LINE ON COMMA
      record = line.strip.split(",").map { |e| e.strip }

      # ADD MAPPING FROM SOURCE TO DESTINATION
      records[record[SOURCE].to_sym] = [record[RECTYPE], nil, record[DESTINATION]]
    end
  }
  records
end

# resolve(records, lookup_chain, domain) : returns lookup_chain having domain
#     to domain to ip mapping sequence
def resolve(records, lookup_chain, domain)
  # CASE IF RECORD NOT FOUND
  if records.keys.find { |e| e == domain.to_sym } == nil

    # ADD APPROPRIATE MESSAGE TO LOOKUP
    lookup_chain = ["Error: record not found for #{domain}"]

    # RETURN THE LOOKUP
    lookup_chain

    # IF DESTINATION IS ANOTHER DOMAIN
  elsif records[domain.to_sym][RECTYPE] == "CNAME"

    # PUSH THE DESTINATION DOMAIN TO LOOKUP
    lookup_chain.push(records[domain.to_sym][DESTINATION])

    # RECURSIVELY CALL FOR DESTINATION DOMAIN TO RESOLVE
    resolve(records, lookup_chain, lookup_chain.last)

    # IF DESTINATION IS IP ADDRESS
  elsif records[domain.to_sym][RECTYPE] == "A"

    # PUSH THE DESTINATION DOMAIN TO LOOKUP
    lookup_chain.push(records[domain.to_sym][DESTINATION])

    # RETURN THE LOOKUP
    lookup_chain
  end
end

# ......................
# ......................

# To complete the assignment, implement `parse_dns` and `resolve`.
# Remember to implement them above this line since in Ruby
# you can invoke a function only after it is defined.
dns_records = parse_dns(dns_raw)
lookup_chain = [domain]
lookup_chain = resolve(dns_records, lookup_chain, domain)
puts lookup_chain.join(" => ")
