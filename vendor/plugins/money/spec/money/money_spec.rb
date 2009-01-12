require File.dirname(__FILE__) + '/../spec_helper'

describe Money do
  
  before do
    @can1  = Money.ca_dollar(100)
    @can2  = Money.ca_dollar(200)
    @can3  = Money.ca_dollar(300)
    @us1   = Money.us_dollar(100)
    
    Money.bank = NoExchangeBank.new
    Money.default_currency = "USD"
  end
  
  it "should use USD as the default currency" do
    Money.default_currency.should == 'USD'
    Money.new(100).currency.should == 'USD'
  end
  
  it "should use Money.default_currency as the default currency" do
    Money.default_currency = 'CAD'
    Money.new(100).currency.should == 'CAD'
  end
  
  describe "==" do
    it "should be true for itself" do
      amount = Money.new(5)
      amount.should == amount
    end
    
    it "should be true for itentical values" do
      Money.new(1).should == Money.new(1)
    end
    
    it "should be false for different amounts" do
      Money.new(1).should_not == Money.new(2)
    end
    
    it "should be false for different currencies" do
      Money.new(1, 'USD').should_not == Money.new(2, 'CAD')
    end
  end
  
  describe "<=>" do
    it "should compare cents for same currency" do
      @can1.should < @can2
      @can3.should > @can2
    end
    
    it "should exchange to same currency when different" do
    end
  end
  
  it "sanity" do
    [@can1, @can2, @can3].should == [@can1, @can2, @can3]
    [@can3, @can2, @can1].sort.should == [@can1, @can2, @can3]
    [@can3, @can2, @can1].should_not == [@can1, @can2, @can3]
    ([@can1, @can2, @can3] & [@can1]).should == [@can1]

    ([@can1] | [@can2]).should == [@can1, @can2]

  end
  
  describe "*" do
    it "should multiply the cents" do    
      (Money.ca_dollar(100) * 55).should == Money.ca_dollar(5500)
      (Money.ca_dollar(100) * 1.50).should == Money.ca_dollar(150)
      (Money.ca_dollar(100) * 0.50).should == Money.ca_dollar(50)
    end
    
    it "multiply preserve the precision" do
      (Money.new(504, 'USD', 3) * 2).should == Money.new(1008, 'USD', 3)
    end
  end
  
  describe "/" do
    it "should divide the cents" do
      (Money.ca_dollar(5500) / 55).should == Money.ca_dollar(100)
      (Money.ca_dollar(200) / 2).should == Money.ca_dollar(100)
    end
    
    it "should preserve the precision" do
      (Money.new(5500, 'USD', 4) / 55).should == Money.new(100, 'USD', 4)
      (Money.new(200, 'USD', 3) / 2).should == Money.new(100, 'USD', 3)
    end
  end

  describe "+" do
    it "should add the cents" do
      (Money.new(1) + Money.new(2)).should == Money.new(3)
    end
    
    it "should use the highest precision" do
      (Money.new(30, 'USD', 2) + Money.new(700, 'USD', 3)).should == Money.new(1000, 'USD', 3)
    end
  end

  describe "-" do
    it "should subtract the cents" do
      (Money.new(3) - Money.new(2)).should == Money.new(1)
    end

    it "should be a negative value when subtracting from zero" do
     (Money.empty - 12.to_money).should == -12.to_money
    end

    it "should use the highest precision" do
      (Money.new(50, 'USD', 2) - Money.new(50, 'USD', 3)).should == Money.new(450, 'USD', 3)
    end
  end

  describe "negative" do
    it "should negate the cents" do
      (-Money.new(43, 'CAD')).should == Money.new(-43, 'CAD')
    end
    
    it "should preserve the precision" do
      (-Money.new(2979, 'CAD', 3)).should == Money.new(-2979, 'CAD', 3)
    end
  end
  
  describe "zero?" do
    it "should be true for zero cents" do
      Money.empty.should be_zero
    end
    
    it "should be false for non-zero cents" do
      Money.ca_dollar(1).should_not be_zero
      Money.ca_dollar(-1).should_not be_zero
    end
  end

  describe "format" do
    it "format the cents with the currency symbol" do
      @can1.format.should == "$1.00"
    end
    
    it "should include the currency if :with_currency is specified" do
      @can1.format(:with_currency).should == "$1.00 CAD"
    end
    
    it "should not include cents if :no_cents is specified" do
      @can1.format(:no_cents).should == "$1"
      Money.ca_dollar(39000).format(:no_cents).should == "$390"
      Money.ca_dollar(570).format(:no_cents).should == "$5"
    end
    
    it "should allow rules to be combined" do
      Money.ca_dollar(570).format([:no_cents, :with_currency]).should == "$5 CAD"
      Money.ca_dollar(570).format(:no_cents, :with_currency).should == "$5 CAD"
    end
    
    it "should allow HTML formatting of currency" do
      Money.ca_dollar(570).format([:html, :with_currency]).should == "$5.70 <span class=\"currency\">CAD</span>"
    end

    it "should format zero as normal" do
      Money.empty.format.should == '$0.00'
    end

    it "should allow custom value for zero" do
      Money.zero = 'zilch'
      Money.empty.format.should == 'zilch'
      Money.zero = nil # reset back to default
    end

  end
  
  describe "to_precision" do
    it "should convert the cents to the precision" do
      Money.new(50, 'USD', 2).to_precision(3).should == Money.new(500, 'USD', 3)
      Money.new(555, 'USD', 3).to_precision(2).should == Money.new(56, 'USD', 2)
      Money.new(56, 'CAD', 2).to_precision(2).should == Money.new(56, 'CAD', 2)
    end
  end
  
  describe "to_s" do
    it "should format the cents" do
      Money.ca_dollar(100).to_s.should == "1.00"
      Money.ca_dollar(39050).to_s.should == "390.50"
    end

    it "should preserve the precision" do
      Money.new(505, 'USD', 3).to_s.should == "0.505"
      Money.new(4, 'USD', -3).to_s.should == "4"
    end
    
    it "should convert to the given output precision" do
      Money.new(4, 'USD', -3).to_s(0).should == "4000"
      Money.new(505, 'USD', 3).to_s(2).should == "0.51"
      Money.new(504, 'USD', 3).to_s(2).should == "0.50"
      Money.new(1001, 'USD', 3).to_s(2).should == "1.00"
    end
  end
  
  describe "to_f" do
    it "should convert cents to a float" do
      5.75.to_money.to_f.should == 5.75
    end
    
    it "should preserve the precision" do
      Money.new(5755, 'USD', 3).to_f.should == 5.755
    end
  end
  
  it "real exchange" do   
    Money.bank = VariableExchangeBank.new
    Money.bank.add_rate("USD", "CAD", 1.24515)
    Money.bank.add_rate("CAD", "USD", 0.803115)
    Money.ca_dollar(124).should == Money.us_dollar(100).exchange_to("CAD")
    Money.us_dollar(80).should == Money.ca_dollar(100).exchange_to("USD")
  end
  
end