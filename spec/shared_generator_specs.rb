shared_examples_for "a generator" do
  
  it "returns a value between 0.0 and 1.0 (inclusive) for a key" do
    value = @it.get(:any_key)
    value.should_not be_nil
    value.should >= 0.0
    value.should <= 1.0
  end
  
  it "allows setting a maximum"
  
  
end