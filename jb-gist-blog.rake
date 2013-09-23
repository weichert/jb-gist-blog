require 'jist'

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
  tmpfilename = "#{dirname}/#{date}-#{slug}.#{CONFIG['post_ext']}"
  if Dir.exist?(dirname)
    abort("rake aborted! #{dirname} already exists")
  end
  Dir.mkdir(dirname)

  # TODO
  # create gist with filename as filename
  # maybe use heredoc to create gist
  puts "Creating new post: #{tmpfilename}"
  open(tmpfilename, 'w') do |post|
    post.puts "---"
    post.puts "layout: post"
    post.puts "title: \"#{title.gsub(/-/,' ')}\""
    post.puts 'description: ""'
    post.puts "category: "
    post.puts "tags: []"
    post.puts "---"
    post.puts "{% include JB/setup %}"
  end
end # task :post
