#             RUBY DECRYPTION PROGRAM
# Usage : ```$ ruby decrypt.rb <enc_file_name> <password>```
#
# Example Usage :
#       ``` $ ruby decrypt.rb textfile.enc changeme```

require "aes"

enc_file = ARGV[0]
password = ARGV[1]
decrypted = AES.decrypt(File.read(enc_file), password)

target_file = "#{enc_file.split(".")[0]}.rec"
File.open(target_file, "wb") { |f| f.write(decrypted) }
