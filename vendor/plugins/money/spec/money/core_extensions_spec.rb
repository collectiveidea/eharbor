require File.dirname(__FILE__) + '/../spec_helper'

describe Numeric do

  describe "to_money" do
    it "should convert a number to dollars" do
      100.to_money.should == Money.new(10000)
    end
    
    it "should preserve negative values" do
      -100.to_money.should == Money.new(-10000)
    end
    
    it "should use the specified precision" do
       1.to_money(3).should == Money.new(1000, Money.default_currency, 3)
    end
    
  end
  
end

describe Float do
  describe "to_money" do
    it "should convert a number to dollars" do
      100.38.to_money.should == Money.new(10038)
    end

    it "should preserve negative values" do
      -100.50.to_money.should == Money.new(-10050)
    end
    
    it "should default to a precision of 2" do
      5.0.to_money.should == Money.new(500, 'USD', 2)
      5.00.to_money.should == Money.new(500, 'USD', 2)
    end
    
    it "should automatically use higher precisions" do
      5.055.to_money.should == Money.new(5055, 'USD', 3)
    end
    
    it "should use the specified precision" do
      5.055.to_money(2).should == Money.new(506, 'USD', 2)
    end
  end
end

describe String do
  describe "to_money" do
    it "should convert the value to a money object" do
      "4.10".to_money.should == Money.new(410)
    end
    
    it "should work with out cents" do
      "$1".to_money.should == Money.new(100)
      "1".to_money.should == Money.new(100)
    end
    
    it "should perserve cents" do
      "$1.37".to_money.should == Money.new(137)
    end
    
    it "should use the specified currency" do
      "CAD $1.00".to_money.should == Money.new(100, 'CAD')
    end
    
    it "should preserve negative amounts" do
      "-100".to_money.should == Money.new(-10000)
      "$-100".to_money.should == Money.new(-10000)
    end
    
    it "should work with commas" do
      '$1,234.56'.to_money.should == Money.new(123456)
    end
    
    it "should default to a precision of 2" do
      '5'.to_money.should == Money.new(500, 'USD', 2)
      '5.0'.to_money.should == Money.new(500, 'USD', 2)
      '5.00'.to_money.should == Money.new(500, 'USD', 2)
    end
    
    it "should automatically use higher precisions" do
      '5.055'.to_money.should == Money.new(5055, 'USD', 3)
    end
    
    it "should use the specified precision" do
      '5.055'.to_money(2).should == Money.new(506, 'USD', 2)
    end
    
  end
end