def diff_files(subpath)
  assert((system "/bin/bash hw1.sh #{REFERENCE_FILE_PATH}/#{subpath}"), "hw1 script did not return happily")
  ['mail', 'tokens', 'token_counts', 'state_counts'].each do |fname|
    assert((system "sort #{fname}.csv > #{fname}-sorted.csv"), "sort did not return happily")
    assert_equal('', `diff #{fname}-sorted.csv #{REFERENCE_FILE_PATH}/#{fname}-sorted.csv`)
    assert((system "rm #{fname}-sorted.csv"), "rm did not return happily")
  end
end