root = "/home/mario/apps/spblog" # e.g. /var/apps/rails_blog/current
shared_dir = "#{root}/shared"
working_directory root
pid "#{shared_dir}/pids/unicorn.pid"
stderr_path "#{shared_dir}/log/unicorn.log"
stdout_path "#{shared_dir}/log/unicorn.log"

worker_processes 1 # update this with your preference
timeout 30
preload_app true

# listen '/tmp/unicorn.spblog.sock', backlog: 64
listen "#{shared_dir}/sockets/unicorn.sock", backlog: 64

before_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and
      ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  defined?(ActiveRecord::Base) and
      ActiveRecord::Base.establish_connection
end

# Force the bundler gemfile environment variable to
# reference the capistrano "current" symlink
=begin
before_exec do |_|
  ENV['BUNDLE_GEMFILE'] = File.join(root, 'Gemfile')
end
=end
