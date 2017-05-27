require 'test_helper'
require 'fileutils'

describe Myapp::Server do
  before  do
    Myapp::Server.close(50_000) if Myapp::Server.in_service?(50_000)
  end

  it 'should listen for any connection' do
  end

  it 'should log data by default on ~/myapp.log' do
    # system("rm ~/myapp.log")
    # server = Myapp::Server.new(50000)
    # server.start
    # # server.join
    # # Myapp::Client.post 'Hello, world!', '127.0.0.1', 50000
    # # `myapp client post -d "Hello, world!"`
    # out = `cat ~/myapp.log`
    # out.match(/Hello, world!/)
    # server.stop
  end

  it 'should accept data from a client' do
  end

  describe 'when there is another server at the same address and port' do
    it 'should give en error' do
    end
  end
end
