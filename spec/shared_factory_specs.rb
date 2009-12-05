require 'rubyonacid/factory'

include RubyOnAcid

shared_examples_for "a factory" do
  
  describe "#get_unit" do
    it "returns a value between 0.0 and 1.0 (inclusive) for a key" do
      value = @it.get_unit(:any_key)
      value.should_not be_nil
      value.should >= 0.0
      value.should <= 1.0
    end
  end
  
  describe "#within" do
    it "allows setting a maximum" do
      @it.within(:any_key, 0.0, 1.0).should <= 1.0
      @it.within(:any_key, 0.0, 1.5).should <= 1.5
      @it.within(:any_key, 0.0, 2.0).should <= 2.0
      @it.within(:any_key, 0.0, 3.0).should <= 3.0
      @it.within(:any_key, 0.0, 10.0).should <= 10.0
      @it.within(:any_key, 0.0, 100.0).should <= 100.0
      @it.within(:any_key, 0.0, 1000.0).should <= 1000.0
      @it.within(:any_key, 0.0, 10000.0).should <= 10000.0
      @it.within(:any_key, -2.0, -1.0).should <= -1.0
      @it.within(:any_key, -10.0, -2.0).should <= -2.0
      @it.within(:any_key, -100.0, -10.0).should <= -10.0
    end
    it "allows setting a minimum" do
      @it.within(:any_key, 0.0, 1.0).should >= 0.0
      @it.within(:any_key, 1.5, 2.5).should >= 1.5
      @it.within(:any_key, 2.0, 10.0).should >= 2.0
      @it.within(:any_key, 3.0, 20.0).should >= 3.0
      @it.within(:any_key, 10.0, 30.0).should >= 10.0
      @it.within(:any_key, 100.0, 100000.0).should >= 100.0
      @it.within(:any_key, 1000.0, 100000.0).should >= 1000.0
      @it.within(:any_key, 10000.0, 100000.0).should >= 10000.0
      @it.within(:any_key, -1.0, 1.0).should >= -1.0
      @it.within(:any_key, -2.0, 1.0).should >= -2.0
      @it.within(:any_key, -10.0, 1.0).should >= -10.0
    end
  end
  
  describe "#get" do
    it "allows setting a maximum" do
      @it.get(:a, :max => 2.0).should <= 2.0
      @it.get(:b, :max => 10.0).should <= 10.0
      @it.get(:c, :max => 100.0).should <= 100.0
      @it.get(:d, :max => 1000.0).should <= 1000.0
    end
    it "allows setting a minimum" do
      @it.get(:a, :min => 2.0).should >= 2.0
      @it.get(:b, :min => -1.0).should >= -1.0
      @it.get(:c, :min => -100.0).should >= -100.0
      @it.get(:d, :min => 1000.0).should >= 1000.0
    end
    it "uses a default minimum of 0.0" do
      @it.get(:a).should >= 0.0
      @it.get(:a, :max => 10.0).should >= 0.0
    end
    it "uses a default maximum of 1.0" do
      @it.get(:a).should <= 1.0
    end
    it "keeps the minimum and maximum between calls for a given key" do
      @it.get(:a, :max => 2.0).should <= 2.0
      10.times do
        @it.get(:a).should <= 2.0
      end
      @it.get(:b, :min => 2.0).should >= 2.0
      10.times do
        @it.get(:b).should >= 2.0
      end
    end
  end
    
end
