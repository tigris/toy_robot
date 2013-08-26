require 'minitest/autorun'

class TestRobotExecutable < MiniTest::Unit::TestCase
  def setup
    root        = File.expand_path(File.join(File.dirname(__FILE__), '..'))
    @sample_dir = File.join(root, 'test', 'samples')
    @executable = File.join(root, 'bin', 'robot')
  end

  def test_sample_a
    out = `#{@executable} #{File.join @sample_dir, 'a.txt'}`
    assert_equal '0,1,NORTH', out.chomp
  end

  def test_sample_b
    out = `#{@executable} #{File.join @sample_dir, 'b.txt'}`
    assert_equal '0,0,WEST', out.chomp
  end

  def test_sample_c
    out = `#{@executable} #{File.join @sample_dir, 'c.txt'}`
    assert_equal '3,3,NORTH', out.chomp
  end
end
