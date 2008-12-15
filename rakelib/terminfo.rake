with 'rakelib/terminfo.rb' do |script|
  with homedir('.screenrc_terminfo') do |outfile|
    file outfile => script do
      ruby "#{script} --screen >#{outfile}"
    end
    task 'etc:all' => outfile
  end
  with homedir('.sh.d/terminfo.sh') do |outfile|
    file outfile => script do
      ruby "#{script} --shell  >#{outfile}"
    end
    task 'sh:all' => outfile
  end
end
