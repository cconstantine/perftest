require 'bundler'
Bundler.require

require "rvm/capistrano"

role :test, "ec2-67-202-13-214.compute-1.amazonaws.com"
role :test, "ec2-23-22-139-254.compute-1.amazonaws.com"
role :test, "ec2-23-20-251-142.compute-1.amazonaws.com"
role :test, "ec2-23-20-75-244.compute-1.amazonaws.com"
role :test, "ec2-23-22-167-18.compute-1.amazonaws.com"
role :test, "ec2-54-242-69-159.compute-1.amazonaws.com"
role :test, "ec2-50-19-67-48.compute-1.amazonaws.com"
role :test, "ec2-50-19-164-36.compute-1.amazonaws.com"
role :test, "ec2-54-242-54-126.compute-1.amazonaws.com"
role :test, "ec2-23-22-25-118.compute-1.amazonaws.com"
role :test, "ec2-107-21-149-106.compute-1.amazonaws.com"
role :test, "ec2-23-20-1-25.compute-1.amazonaws.com"
role :test, "ec2-54-242-52-253.compute-1.amazonaws.com"
role :test, "ec2-50-17-114-223.compute-1.amazonaws.com"
role :test, "ec2-50-17-170-197.compute-1.amazonaws.com"
role :test, "ec2-54-242-77-77.compute-1.amazonaws.com"
role :test, "ec2-184-72-134-16.compute-1.amazonaws.com"
role :test, "ec2-54-242-35-188.compute-1.amazonaws.com"
role :test, "ec2-54-242-85-28.compute-1.amazonaws.com"
role :test, "ec2-107-22-81-57.compute-1.amazonaws.com"


set :runner, "cconstantine"
set :user, "cconstantine"

set :rvm_type, :user
set :rvm_ruby_string, 'ruby-1.9.3-p286@perftest'

namespace :perftest do
  task :do_it_live do
    upload(".", "/home/#{user}/perftest", :via => :scp, :recursive => true, :roles => :test)
    run "cd ~/perftest && bundle"
    run "cd ~/perftest && PERF_TEST_TOTAL=200 PERF_TEST_RAMP=6 xvfb-run bundle exec ruby dotest.rb"
  end
end