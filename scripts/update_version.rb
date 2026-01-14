file = 'lib/unifi/version.rb'
version = ENV['NEXT_VERSION']

content = File.read(file)
content.sub!(/VERSION = '.*'/, "VERSION = '#{version}'")
File.write(file, content)
