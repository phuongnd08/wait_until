module WaitUntil

  class Wait

    class << self

      attr_accessor :default_timeout_in_seconds

      def until_true!(description, options={}, &block)
        operation = WaitUntil::Operation.new(description, options)
        raise operation.failure_message unless operation.eventually_true?(&block)
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
