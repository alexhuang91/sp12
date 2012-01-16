require 'test/unit'
require './test/diff_files'
REFERENCE_FILE_PATH = "."

class SanityTest < Test::Unit::TestCase
  def test_sanity
    diff_files("enron_tiny")
  end
end

