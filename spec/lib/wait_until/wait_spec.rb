describe WaitUntil::Wait do

  let(:description) { "some operations description" }
  let(:options)     { {} }

  before(:context) do
    @initial_default_timeout = WaitUntil::Wait.default_timeout_in_seconds
    WaitUntil::Wait.default_timeout_in_seconds = 1
  end

  after(:context) { WaitUntil::Wait.default_timeout_in_seconds = @initial_default_timeout }

  shared_examples_for "a wait method that times-out" do

    it "raises an error indicating the operation timed-out" do
      expect(subject).to raise_error(/Timed-out waiting until '#{description}'/i)
    end

    context "and a timeout is provided" do

      let(:timeout_in_seconds) { 2 }
      let(:options)            { { timeout_in_seconds: timeout_in_seconds } }

      it "waits until at least that period of time before raising an error" do
        start_time = Time.now

        subject.call rescue nil

        period_of_time_waited = (Time.now - start_time)
        expect(period_of_time_waited).to be >= timeout_in_seconds
      end

    end

  end

  describe "::until_true!" do

    subject { lambda { described_class.until_true!(description, options, &block) } }

    context "when the block returns true" do

      let(:block) { lambda { true } }

      it "executes without error" do
        expect(subject).to_not raise_error
      end

    end

    context "when the blocks always returns false" do

      let(:block) { lambda { false } }

      it_behaves_like "a wait method that times-out"

    end

    context "when the block eventually returns true" do

      let(:block) do
        invocation_count = 0
        lambda do
          invocation_count += 1
          invocation_count == 3
        end
      end

      it "executes without error" do
        expect(subject).to_not raise_error
      end

    end

  end

  describe "::until_false!" do

    subject { lambda { described_class.until_false!(description, options, &block) } }

    context "when the block returns false" do

      let(:block) { lambda { false } }

      it "executes without error" do
        expect(subject).to_not raise_error
      end

    end

    context "when the blocks always returns true" do

      let(:block) { lambda { true } }

      it_behaves_like "a wait method that times-out"

    end

    context "when the block eventually returns false" do

      let(:block) do
        invocation_count = 0
        lambda do
          invocation_count += 1
          invocation_count < 3
        end
      end

      it "executes without error" do
        expect(subject).to_not raise_error
      end

    end

  end

  describe "::until!" do

    subject { lambda { described_class.until!(description, options, &block) } }

    context "when the block executes without error" do

      let(:block) { lambda { nil } }

      it "executes without error" do
        expect(subject).to_not raise_error
      end

    end

    context "when the block raises an error indefinitely" do

      let(:block) { lambda { raise "Forced Error" } }

      it_behaves_like "a wait method that times-out"

    end

    context "when the block eventually executes without error" do

      let(:block) do
        invocation_count = 0
        lambda do
          invocation_count += 1
          raise "Forced Error" if invocation_count < 3
        end
      end

      it "executes without error" do
        expect(subject).to_not raise_error
      end

    end

  end

end
