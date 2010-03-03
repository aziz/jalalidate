require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe JalaliDate do
  
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

  it "should return today, yesterday, and tomorrow date according to jalali calendar" do
    Date.stub!(:today).and_return(Date.new(2010,1,1))
    JalaliDate.today.should == JalaliDate.new(1388,10,11)
    JalaliDate.yesterday.should == JalaliDate.new(1388,10,10)
    JalaliDate.tomorrow.should == JalaliDate.new(1388,10,12)        
  end

  it "should distinguish invalid jalali dates" do
    JalaliDate.valid?(1388,13,11).should be_false
    JalaliDate.valid?(-1388,11,11).should be_false
    JalaliDate.valid?(1388,1,45).should be_false
    JalaliDate.valid?(1388,12,30).should be_false
    JalaliDate.valid?(1387,12,30).should be_true
  end

  it "should distinguish leap years" do
    JalaliDate.leap?(1387).should be_true
    JalaliDate.leap?(1388).should be_false
  end
  
  it "should convert to gregorian date correctly" do
    jdate = JalaliDate.new(1388,10,11)
    jdate.to_g.should == Date.new(2010,1,1)
  end
  
  it "should convert to string, array and hash correctly" do
    jdate = JalaliDate.new(1388,10,11)
    jdate.to_s.should == "1388/10/11"
    jdate.to_a.should == [1388,10,11]
    jdate.to_hash.should == {:year => 1388, :month => 10, :day => 11}
  end
  
  it "should be able to add and substract days from the currect jalai date object" do
    jdate = JalaliDate.new(1388,10,11)
    five_days_later = jdate + 5
    twenty_days_ago = jdate - 20
    five_days_later.should == JalaliDate.new(1388,10,16)
    twenty_days_ago.should == JalaliDate.new(1388,9,21)
  end
  
  it "should be able to compare two jalali dates" do
    jdate = JalaliDate.new(1388,10,11)
    next_month_jdate = JalaliDate.new(1388,11,11)
    next_month_jdate.<=>(jdate).should == 1
    jdate.<=>(next_month_jdate).should == -1
    jdate.<=>(jdate).should == 0
  end
  
  it "should now its next and previous dates" do
    jdate = JalaliDate.new(1388,10,11)
    jdate.next.should == JalaliDate.new(1388,10,12)
    jdate.previous.should == JalaliDate.new(1388,10,10)
  end
  
  

end