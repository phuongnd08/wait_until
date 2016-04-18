describe WaitUntil::Operation do

  class InvocationData

    class << self
      attr_accessor :counter
    end

  end

  let(:description)        { "some operations description" }
  let(:timeout_in_seconds) { 1 }
  let(:options)            { { timeout_in_seconds: timeout_in_seconds } }

  let(:operation) { described_class.new(description, options) }

  before(:example) { InvocationData.counter = 0 }

  describe "#eventually_true?" do

    subject { operation.eventually_true?(&block) }

    context "when the block returns true" do

      let(:block) { lambda { true } }

      it "returns true" do
        expect(subject).to be(true)
      end

    end

    context "when the blocks always returns false" do

      let(:block) { lambda { false } }

      it "returns false" do
        expect(subject).to be(false)
      end

      context "and a timeout is provided" do

        let(:timeout_in_seconds) { 2 }
        let(:options)            { { timeout_in_seconds: timeout_in_seconds } }

        it "waits until at least that period of time before returning false" do
          start_time = Time.now

          subject

          period_of_time_waited = (Time.now - start_time)
          expect(period_of_time_waited).to be >= timeout_in_seconds
        end

      end

    end

    context "when the block eventually returns true" do

      let(:block) do
        lambda do
          InvocationData.counter += 1
          InvocationData.counter == 3
        end
      end

      it "returns true" do
        expect(subject).to be(true)
      end

    end

  end

  describe "#failure_message" do

    subject { operation.failure_message }

    before(:example) { operation.eventually_true?(&block) }

    shared_examples_for "a standard failure message" do

      it "indicates a time-out occurred" do
        expect(subject).to include("Timed-out")
      end

      it "contains the operations description" do
        expect(subject).to include(description)
      end

    end

    context "when no exception occurred evaluating the operation" do

      let(:block) { lambda { false } }

      it_behaves_like "a standard failure message"

    end

    context "when an exception occurred evaluating the operation" do

      let(:block) do
        lambda do
          InvocationData.counter += 1
          raise "Forced error #{InvocationData.counter}"
        end
      end

      it_behaves_like "a standard failure message"

      it "includes the last error" do
        expect(subject).to include("Forced error #{InvocationData.counter}")
      end

    end

  end

end
