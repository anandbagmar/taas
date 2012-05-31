module TaaS
  module CommandRunner
    def execute(dir, command)
      return nil if command.nil? || dir.nil?
      Dir.chdir(dir)
      command = `#{command}`
    end
  end
end

