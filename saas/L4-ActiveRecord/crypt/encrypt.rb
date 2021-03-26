#             RUBY ENCRYPTION PROGRAM
# Usage : ```$ ruby encrypt.rb <file_name> <password>```
#
# Example Usage :
#       ``` $ ruby encrypt.rb textfile changeme```

require "aes"

source_file = ARGV[0]
password = ARGV[1]
encrypted = AES.encrypt(File.read(source_file), password)

target_file = "#{source_file}.enc"
File.open(target_file, "wb") { |f| f.write(encrypted) }
