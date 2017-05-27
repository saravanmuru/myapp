require 'gserver'
require 'logger'

# listen to a given port
# accepts data from client
# send ack to client
# close the connection
#
# Can accept multiple client
# Can listen on multiple ports
module Myapp

  class Server < GServer
    def initialize(port, host = '127.0.0.1', max_connections = 10, stdlog = $stdout, audit = true)
      @logger = Logger.new(File.expand_path(stdlog)) if stdlog != $stdout
      super(port, host, max_connections, $stdout, audit)
    end

    def serve(io)
      data = io.read(1024)
      log "client:#{io.peeraddr[1]} #{io.peeraddr[2]}<#{io.peeraddr[3]}> post #{data.bytesize} bytes\n#{data}"
      puts ''
      io.puts('ACK!')
    end

    def stopping
      log("#{self.class} #{@host}:#{@port} stop")
      @logger.close
    end

    def log(message)
      if @stdlog
        @stdlog.puts("[#{Time.new.ctime}] %s" % message)
        @stdlog.flush
      end

      @logger.info message if @logger
    end
  end
end
