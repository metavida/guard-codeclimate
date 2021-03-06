require 'guard/compat/plugin'
require 'guard/code_climate/version'
require 'guard/shell'
require 'shellwords'

module Guard
  class CodeClimate < Shell
    # Call #run_on_change for all files which match this guard.
    def run_all
      run_on_modifications(Compat.matching_files(self, Dir.glob('{,**/}*{,.*}')))
    end

    # Print the result of the command(s), if there are results to be printed.
    def run_on_modifications(files)
      files.each do |path|
        puts "Performing Code Climate analysis of #{path.inspect}"
        ::Guard::Dsl.new.eager("codeclimate analyze #{Shellwords.escape(path)}")
      end
    end
  end
end
