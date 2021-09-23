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
    `#{commands.join(" && ")}`
  end

  def commands
    [
      %(cd "#{dir}"),
      "git pull",
      "git add .",
      "git commit -m $'#{commit_messages.join('\n')}'",
      "git push",
    ]
  end

  def commit_messages
    [
      "Updated #{changes.size} files at #{Time.now.strftime("%Y-%m-%d %H:%M:%S")}",
      ""
    ].concat(sanitised_changes)
  end

  def sanitised_changes
    changes.map do |change|
      change.gsub("'") {"\\'"}
    end
  end
end

NotesSync.new(options[:dir]).process
