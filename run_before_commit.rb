#!/usr/bin/ruby

require 'open3'
require 'shellwords'

PARENT_DIR = 'out'
resume_path = Dir["#{PARENT_DIR}/*.pdf"][0] #=> out/Wenlin Huang - Software Engineer.pdf
resume_name = File.basename(resume_path, File.extname(resume_path))  #=> Wenlin Huang - Software Engineer
resume_name_shell_escaped = Shellwords.escape(resume_name)

# Convert pdf to png which can be shown in the README section
cmd = "convert -density 576 #{PARENT_DIR}/#{resume_name_shell_escaped}.pdf #{PARENT_DIR}/#{resume_name_shell_escaped}.png"
stdout, stderr, wait_thr = Open3.capture3(cmd)
print "#{stdout}"

if wait_thr.exitstatus != 0
  puts "stderr: \n#{stderr}"
  puts "Exiting the program"
  exit(1)
end
