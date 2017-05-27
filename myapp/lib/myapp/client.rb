require 'socket'
module Myapp
  module Client
    def self.read_1024_bytes_from_dev_urandom
      File.read('/dev/urandom', 1024)
    end

    # Returns a copy of String
    def self.clean_out_non_utf8_compliant_chars(str, token = '')
      str.encode(Encoding::UTF_8, invalid: :replace, undef: :replace, replace: token)
    end

    def self.replace_all_spaces_with_asterisk(str)
      str.gsub(/\s/, '*')
    end

    def self.clean_data(token = '')
      str = read_1024_bytes_from_dev_urandom
      clean = clean_out_non_utf8_compliant_chars(str, token)
      replace_all_spaces_with_asterisk(clean)
    end

    def self.post(data, server, port)
      size = data.bytesize
      puts "Sending #{size} bytes to port #{port} on #{server}."
      socket = TCPSocket.open(server, port)
      puts data
      socket.write(data)

      # wait for the ACK from the server
while line = socket.gets # Read lines from socket
   if line =~ /ACK!/
     puts "I am happy you get the data"
     break
   end
end

      socket.close
    rescue Errno::ECONNREFUSED
      puts "Sorry! Connection refused by #{server} on port #{port}"
    end
  end
end
