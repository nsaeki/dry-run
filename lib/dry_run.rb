require "dry_run/version"

module DryRun
  class << self
    attr_accessor :dry_run_state
  end

  def dry_run(method, message = nil, retval = nil)
    unless method_defined?(method)
      raise NoMethodError, "method is not defined #{method} in #{self}"
    end

    define_method(method) do |*args|
      message ||= method.to_s.capitalize.gsub('_', ' ')
      msg = [message, *args].join(' ')

      case DryRun.dry_run_state
      when :dry_run, true
        puts "[DRY RUN] #{msg}"
        return retval
      when :interactive
        print "#{msg}? [y/N] "
        unless $stdin.gets.strip =~ /(y|yes)/i
          puts "Canceled"
          return retval
        end
      when :verbose
        puts msg
      end
      super *args
    end
  end
end
