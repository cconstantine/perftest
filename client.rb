require 'rubygems'
require 'capybara'
require 'capybara/dsl'
require 'capybara-webkit'
require 'benchmark'
require 'syslog-logger'
require 'timeout'


Capybara.run_server = false
Capybara.default_driver = :webkit
Capybara.javascript_driver = :webkit
Capybara.app_host = 'http://localhost:3000'


Syslog.open("perftest", Syslog::LOG_PID, Syslog::LOG_DAEMON | Syslog::LOG_LOCAL7)

class Client
  attr_reader :session
  include Capybara::DSL

  def initialize

    @timeout = 50
    #@session = Capybara::Session.new(:webkit)
    #@session.driver.browser.ignore_ssl_errors
    #@session.driver.enable_logging
  end

  def measure(name, &block)
    t = Benchmark.realtime do
      #puts "#{Process.pid}: Visiting #{path}"

      Timeout::timeout(@timeout) do
        yield block
      end
    end
  rescue
    name = "#{name}: #{$!.message}"
    p ['rescue', name]
  ensure
    p 'ensure'
    p 'asdf'
    msg = "% 04.2f: #{page.status_code} #{name}" % [t || @timeout]
    p 'ensure'
    puts msg
    p 'ensure'
    Syslog.log(Syslog::LOG_LOCAL7, msg)

    p 'ensure'
    #sleep 10
  end

  def m_visit( path)
    measure("visit #{path}") do
      visit(path)
    end
  end

  def m_click_on(name)
    measure("click_on '#{name}'") do
      p "click_on '#{name}'"
      last_path = page.current_path
      p 'before click_on 1'

      click_on name
      p 'before click_on 2'

      page.wait_until(5) {
        p 'before click_on!'
         last_path != page.current_path
        p 'before click_on2!'
      }
      p ' after click_on'
    end
  end

  def m_click_button(name)
    measure("click_on '#{name}'") do
      p "before click_on '#{name}'"
      last_path = page.current_path
      p 'before click_on 1'

      click_button name
      p 'before click_on 2'

      page.wait_until(5) {
        p 'before click_on!'
        last_path != page.current_path
        p 'before click_on2!'
      }
      p ' after click_on'
    end
  end
end
