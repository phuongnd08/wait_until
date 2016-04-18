module WaitUntil

  class Operation

    def initialize(description, options)
      @description        = description
      @timeout_in_seconds = options[:timeout_in_seconds] || ::WaitUntil::Wait.default_timeout_in_seconds
    end

    def eventually_true?(&block)
      start_time = Time.now
      loop do
        return true if true?(&block)
        elapsed_time = Time.now - start_time
        return false if elapsed_time >= @timeout_in_seconds
      end
    end

    def failure_message
      message = "Timed-out waiting until '#{@description}'"
      message << ".  Last observed exception: #{@last_error}" if @last_error
      message
    end

    private

    def true?(&block)
      begin
        !!block.call
      rescue => error
        @last_error = error
        false
      end
    end

  end

end
