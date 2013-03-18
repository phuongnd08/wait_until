describe WaitUntil do

  describe "when loaded" do

    it "should define the global Wait class as the WaitUntil::Wait class" do
      Wait.should eql(WaitUntil::Wait)
    end

  end

end