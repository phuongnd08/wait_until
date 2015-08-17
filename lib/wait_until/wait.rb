module WaitUntil

  class Wait

    class << self

      attr_accessor :default_timeout_in_seconds

      def until_true!(description, options={}, &block)
        timeout_in_seconds = options[:timeout_in_seconds] || self.default_timeout_in_seconds
        start_time = Time.now
        last_exc = nil
        loop do
          begin
            return if block.call
          rescue => exc
            last_exc = exc
          end
          elapsed_time = Time.now - start_time
          if elapsed_time >= timeout_in_seconds
            failure_message = "Timed-out waiting until '#{description}'"
            failure_message << ".  Last observed exception: #{last_exc}" if last_exc
            raise failure_message
          end
        end
      end

      def until_false!(description, options={}, &block)
        until_true!(description, options) { !block.call }
      end

      def until!(description, options={}, &block)
        until_true!(description, options) do
          block.call
          true
        end
      end

    end

    self.default_timeout_in_seconds = ENV["timeout"] ? ENV["timeout"].to_i : 20

  end

end
