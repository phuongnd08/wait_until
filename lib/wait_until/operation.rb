module WaitUntil

  class Operation

    def initialize(description, options)
      @description        = description
      @timeout_in_seconds = options[:timeout_in_seconds] || ::WaitUntil::Wait.default_timeout_in_seconds
      @on_failure         = options[:on_failure]
    end

    def eventually_true?(&block)
      @start_time = Time.now
      loop do
        return true if true?(&block)
        return false if timed_out?
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

    def timed_out?
      elapsed_time = Time.now - @start_time
      is_timed_out = elapsed_time >= @timeout_in_seconds
      @on_failure.call if @on_failure if is_timed_out
      is_timed_out
    end

  end

end
