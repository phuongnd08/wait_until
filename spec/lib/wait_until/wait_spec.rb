describe WaitUntil::Wait do

  before(:all) do
    @initial_default_timeout = WaitUntil::Wait.default_timeout_in_seconds
    WaitUntil::Wait.default_timeout_in_seconds = 1
  end

  after(:all) { WaitUntil::Wait.default_timeout_in_seconds = @initial_default_timeout }

  describe ".until_true!" do

    context "when the block returns true" do

      let(:block) do
        lambda { WaitUntil::Wait.until_true!("some operation") { true } }
      end

      it "executes without error" do
        expect(block).to_not raise_error
      end

    end

    context "when the blocks always returns false" do

      let(:timeout_in_seconds) { nil }
      let(:block) do
        lambda do
          WaitUntil::Wait.until_true!("another operation finishes", timeout_in_seconds: timeout_in_seconds) { false }
        end
      end

      it "raises an error indicating the operation timed-out" do
        expect(block).to raise_error(/Timed-out waiting until 'another operation finishes'/i)
      end

      context "and a timeout is provided" do

        let(:timeout_in_seconds) { 2 }

        it "waits until at least a period of time matching the timeout before raising an error" do
          start_time = Time.now

          expect(block).to raise_error

          period_of_time_waited = (Time.now - start_time)
          expect(period_of_time_waited).to be >= timeout_in_seconds
        end

      end

    end

    context "when the block eventually returns true" do

      it "executes without error" do
        invocation_count = 0
        expect(lambda do
          WaitUntil::Wait.until_true!("some operation") do
            invocation_count += 1
            invocation_count == 3
          end
        end).to_not raise_error
      end

    end

  end

  describe ".until_false!" do

    context "when the block returns false" do

      let(:block) do
        lambda { WaitUntil::Wait.until_false!("some operation") { false } }
      end

      it "executes without error" do
        expect(block).to_not raise_error
      end

    end

    context "when the blocks always returns true" do

      let(:timeout_in_seconds) { nil }
      let(:block) do
        lambda do
          WaitUntil::Wait.until_false!("another operation finishes", timeout_in_seconds: timeout_in_seconds) { true }
        end
      end

      it "raises an error indicating the operation timed-out" do
        expect(block).to raise_error(/Timed-out waiting until 'another operation finishes'/i)
      end

      context "and a timeout is provided" do

        let(:timeout_in_seconds) { 2 }

        it "waits until at least a period of time matching the timeout before raising an error" do
          start_time = Time.now

          expect(block).to raise_error

          period_of_time_waited = (Time.now - start_time)
          expect(period_of_time_waited).to be >= timeout_in_seconds
        end

      end

    end

    context "when the block eventually returns false" do

      it "executes without error" do
        invocation_count = 0
        expect(lambda do
          WaitUntil::Wait.until_false!("some operation") do
            invocation_count += 1
            invocation_count < 3
          end
        end).to_not raise_error
      end

    end

  end

  describe ".until!" do

    context "when the block executes without error" do

      let(:block) do
        lambda { WaitUntil::Wait.until!("some operation") { } }
      end

      it "executes without error" do
        expect(block).to_not raise_error
      end

    end

    context "when the block raises an error indefinitely" do

      let(:timeout_in_seconds) { nil }
      let(:block) do
        lambda do
          WaitUntil::Wait.until!("some operation finishes", timeout_in_seconds: timeout_in_seconds) do
            raise "forced error"
          end
        end
      end

      it "raises an error indicating the operation timed-out" do
        expect(block).to raise_error(/Timed-out waiting until 'some operation finishes'/i)
      end

      context "and a timeout is provided" do

        let(:timeout_in_seconds) { 2 }

        it "waits until at least a period of time matching the timeout before raising an error" do
          start_time = Time.now

          expect(block).to raise_error

          period_of_time_waited = (Time.now - start_time)
          expect(period_of_time_waited).to be >= timeout_in_seconds
        end

      end

    end

    context "when the block eventually executes without error" do

      it "executes without error" do
        invocation_count = 0
        expect(lambda do
          WaitUntil::Wait.until!("some operation") do
            invocation_count += 1
            raise "forced error" if invocation_count < 3
          end
        end).to_not raise_error
      end

    end

  end

end
