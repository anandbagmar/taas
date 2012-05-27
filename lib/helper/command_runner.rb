module CommandRunner
  def execute(dir, command)
    return "" if command.nil? || dir.nil?
    Dir.chdir(dir)
    command  = `#{command}`
  end
end
