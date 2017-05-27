require 'test_helper'

describe 'Myapp::Client' do

  it 'can read 1024 bytes from dev urandom' do
    str = Myapp::Client.read_1024_bytes_from_dev_urandom
    assert_equal 1024, str.bytesize
  end

  it 'can replace all spaces with asterisk' do
    {
      ' ' =>   '*',
      ' Hello, world!' => '*Hello,*world!',
      'no-space-at-all' => 'no-space-at-all',
      "\t" => '*'

    }.each do |before, after|
      assert_equal after, Myapp::Client.replace_all_spaces_with_asterisk(before)
    end
  end

  it 'can clean out UTF-8 non complaint chars' do
    {
      'Only UTF8 chars' => 'Only UTF8 chars',
      'o��eX7OV�zG�Z��!H�K�T�zJq��lz!' => 'o��eX7OV�zG�Z��!H�K�T�zJq��lz!'
    }.each do |dirty, clean|
      assert_equal clean, Myapp::Client.clean_out_non_utf8_compliant_chars(dirty)
    end
  end

  it 'can send data to a remote server listening on a given port' do
    remote_host = TCPServer.new(60000)
    out = capture_io { Myapp::Client.post('Hello, World!', '127.0.0.1', 60000) }.join
    out.must_match(/Sending 13 bytes to port 60000 on 127.0.0.1/)
    out.must_match(/Hello, World!/)
    out.must_match(/Bye!/)
    remote_host.close
  end

  it 'generates an error message  when there is no server listening' do
    out = capture_io { Myapp::Client.post('Some Info', '127.0.0.1', 54321) }.join
    out.must_match(/Sorry!/)
  end

end
