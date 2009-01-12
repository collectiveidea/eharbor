require File.dirname(__FILE__) + '/../../spec_helper'
require 'rubygems'
require 'active_record'
require 'money/rails'

ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => File.expand_path(File.dirname(__FILE__) + '/test.db' ))
ActiveRecord::Schema.suppress_messages do
  ActiveRecord::Schema.define do
    create_table :money_examples, :force => true do |t|
      t.integer :credit_amount_in_cents
      t.integer :debit_amount_in_cents
    end
  end
end

class MoneyExample < ActiveRecord::Base
  money :debit_amount
end

describe Money, "using the money declaration in an ActiveRecord model" do
  it "should allow dynamic finders to work the same as composed_of" do
    record = MoneyExample.create!(:debit_amount => 100.to_money)
    MoneyExample.find_by_debit_amount(0.to_money).should be_nil
    MoneyExample.find_by_debit_amount(100.to_money).should == record
  end
  
  describe "setter method" do
    it "should pass on money values" do
      MoneyExample.new(:debit_amount => 1.to_money).debit_amount.should == 1.to_money
    end
    
    it "should convert string values to money objects" do
      MoneyExample.new(:debit_amount => '2').debit_amount.should == 2.to_money
    end

    it "should convert numeric values to money objects" do
      MoneyExample.new(:debit_amount => 3).debit_amount.should == 3.to_money
    end

    it "should treat blank values as nil" do
      MoneyExample.new(:debit_amount => '').debit_amount.should be_nil
    end
    
    it "should allow existing amounts to be set to nil with a blank value" do
      me = MoneyExample.new(:debit_amount => 500.to_money)
      me.update_attribute :debit_amount, ''
      me.debit_amount.should be_nil
    end
  end
end