

def doTest
  require './client'
  client = Client.new
  client.visit('/')
  client.m_click_on "Apply Now"
  client.save_and_open_page
  p "*************************************"
  #client.click_on "How It Works"
  client.m_click_on "Get Started"
  client.save_and_open_page
  p "*************************************"
  sleep 1
end

raise 'must set PERF_TEST_TOTAL and PERF_TEST_RAMP' unless ENV['PERF_TEST_TOTAL'] && ENV['PERF_TEST_RAMP']
pids = Set.new
i = 0


ENV['PERF_TEST_TOTAL'].to_i.times do
  i += 1
  sleep ENV['PERF_TEST_RAMP'].to_f
  p = Process.fork
  if p
    puts "#{i} processes"
    pids << p
  else
    doTest()
    Process.exit
  end
end

puts "Done ramping up"

pids.each do |pid|
  #puts "Waiting on pid: #{pid}"

  Process.wait(pid)
end
