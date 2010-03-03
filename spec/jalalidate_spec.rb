require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe JalaliDate do
  
  # before(:each) do
  # end
  
  it "should initialize with valid year,month,date values" do
    jdate = JalaliDate.new(1388,11,22)
    jdate.should be_instance_of(JalaliDate)
  end

  it "should raise error for invalid year,month,date combination on initialize" do
    lambda { JalaliDate.new(1388,14,22) }.should raise_error(ArgumentError)  # invalid month
    lambda { JalaliDate.new(1388,14,32) }.should raise_error(ArgumentError)  # invalid day
    lambda { JalaliDate.new(1388,14,"22") }.should raise_error(ArgumentError)  # invalid type
    lambda { JalaliDate.new(1388,14,22,11,0) }.should raise_error(ArgumentError)  # invalid arguments
  end

  it "should initialize with a ruby date object" do
    jdate = JalaliDate.new(Date.today)
    jdate.should be_instance_of(JalaliDate)
  end

  it "should populate attr_accessors for jalali year, month and date and attr_reader for gregorian year,month and date" do
    jdate = JalaliDate.new(1388,11,22)
    jdate.year.should eql(1388)
    jdate.month.should eql(11)
    jdate.day.should eql(22)
    jdate.g_year.should eql(2010)
    jdate.g_month.should eql(2)
    jdate.g_day.should eql(11)
  end

  it "should return today, yesterday, and tomorrow date according to jalali calendar" 
  
end