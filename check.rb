#!/usr/bin/env ruby

USAGE = <<-end
check [--out=output-file] FILE
end

puts "Check called with arguments #{ARGV.inspect}"

require "trollop"
require "prawn"

LIB_ROOT = File.dirname(File.realpath(__FILE__))
require File.join(LIB_ROOT, "lib/checklist")
require File.join(LIB_ROOT, "lib/line")

opts = Trollop::options do
  opt :out, "Output checklists to a file or folder.", default: "."
end

out = opts[:out]
out_is_dir = File.directory?(out)
files = ARGV.map{ |f| Dir[f] }.flatten


if files.size > 1 && !out_is_dir
  puts "You've specified a single file with the --out option, but provided multiple inputs."
  exit 1
end

CHECKBOX_WIDTH=30

files.each do |f|
  checklist = Checklist.new(f)

  output_file = if out_is_dir
    File.join(out, File.basename(f, File.extname(f))+".pdf")
  else
    out
  end

  Prawn::Document.generate(output_file) do |doc|
    doc.font "Helvetica"
    checklist.each do |line|
      line.render(doc)
    end
  end
end