require 'open3'

module RunCommandHelpers
  def run_command(cli)
    stdin, stdout, stderr, thread = Open3.popen3(cli)
    console = stdout.readlines.join ''
    yield console if block_given?
  ensure
    thread.kill
    stdin.close
    stdout.close
    stderr.close
  end

  def stop_all_myapp_servers
    system 'pkill -f bin/myapp'
  end
end
