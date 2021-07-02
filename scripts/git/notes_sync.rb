#!/usr/bin/env ruby
require 'optparse'

options = { dir: nil }

OptionParser.new do |parser|
  parser.banner = "Usage: notes_sync.rb --dir=/path/to/notes/dir"

  parser.on("--dir=DIR", String, "Provide the notes dir") do |dir|
    options[:dir] = dir
  end

  parser.parse!(ARGV)

  if options.values.compact.size < options.size
    puts "Missing option values"
    puts parser

    exit
  end
end

class NotesSync
  attr_reader :dir

  def initialize(dir)
    @dir = dir
  end

  def process
    return unless changes_exist?

    sync_changes
  end

  private

  def changes_exist?
    changes.any?
  end

  def changes
    @changes ||= `cd "#{dir}" && git status --porcelain`.split("\n")
  end

  def sync_changes
    %x(
      cd #{dir}
      git pull
      git add .
      git commit #{commit_messages.join(" ")} -e
      git push
    )
  end

  def commit_messages
    [
      "Updated #{changes.size} files at #{Time.now.strftime("%Y-%m-%d %H:%M:%S")}",
      ""
    ].concat(changes).map do |message|
      "-m #{message.inspect}"
    end
  end
end

NotesSync.new(options[:dir]).process
