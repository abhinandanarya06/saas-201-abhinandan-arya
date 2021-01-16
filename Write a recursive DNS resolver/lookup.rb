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

def parse_dns(raw)
  # parse_dns(<list of line strings>)
  # To build domain to domain and domain to IP mapping (HASHMAP)
  # returns records having mapping as follows :-
  #       SOURCE => [ RECORD_TYPE, nil, DESTINATION ]
  records = {}
  raw.each { |line|
    if not(line.strip[0] == "#" or line.strip.length == 0)
      record = line.strip.split(",").map { |e| e.strip }
      records[record[SOURCE].to_sym] = [record[RECTYPE], nil, record[DESTINATION]]
    end
  }
  records
end

def resolve(records, lookup_chain, domain)
  # resolve(<hashmap>, <list of strings>, <string>)
  # To get mapping chain list from source domain to destination IP
  # pushes the answer on lookup_chain and return it after recursive calls
  if records.keys.find { |e| e == domain.to_sym } == nil
    lookup_chain = ["Error: record not found for #{domain}"]
    lookup_chain
  elsif records[domain.to_sym][RECTYPE] == "CNAME"
    lookup_chain.push(records[domain.to_sym][DESTINATION])
    resolve(records, lookup_chain, lookup_chain.last)
  elsif records[domain.to_sym][RECTYPE] == "A"
    lookup_chain.push(records[domain.to_sym][DESTINATION])
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
