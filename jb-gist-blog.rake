require 'gist'

# Overriding a rake task might be a horrible thing to do so use this with caution!
task :post => []; Rake::Task["post"].clear

# Usage: rake post title="A Title" [date="2012-02-09"]
desc "Begin a new post in #{CONFIG['posts']}"
task :post do
  abort("rake aborted: '#{CONFIG['posts']}' directory not found.") unless FileTest.directory?(CONFIG['posts'])
  title = ENV["title"] || "new-post"
  slug = title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  begin
    date = (ENV['date'] ? Time.parse(ENV['date']) : Time.now).strftime('%Y-%m-%d')
  rescue Exception => e
    puts "Error - date format must be YYYY-MM-DD, please check you typed it correctly!"
    exit 1
  end
  dirname = File.join(CONFIG['posts'], "#{date}-#{slug}")
  if Dir.exist?(dirname)
    abort("rake aborted! #{dirname} already exists")
  end
  filename = "#{date}-#{slug}.#{CONFIG['post_ext']}"
  content = <<-END_OF_STRING
---
layout: post
title: \"#{title.gsub(/-/,' ')}\"
description: \"\"
category:
tags: []
---
{% include JB/setup %}"
  END_OF_STRING
  r = Gist.gist(content, :description => title, :filename => filename, :public => true)
  gitaddress = r["html_url"]
  system("git submodule add #{gitaddress}.git #{dirname}")
end # task :post
