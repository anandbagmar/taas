module TaaS
  class CommandExecuter
    def self.execute_command(dir, command)
      return nil if command.nil? || dir.nil? || command.empty? || dir.empty?
      Dir.chdir(dir)
      `#{command}`
    end
  end
end