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

  it "should be able to move the month forward and backward" do
    jdate = JalaliDate.new(1388,10,11)
    five_month_later = jdate >> 5
    five_month_ago = jdate << 5
    five_month_later.should == JalaliDate.new(1389,3,11)
    five_month_ago.should == JalaliDate.new(1388,5,11)
  end

  it "should be able to cycle through dates in different ways, namely, step, upto and downto" do
    jdate = JalaliDate.new(1388,10,10)

    days_string = ""
    jdate.step( jdate + 10 , 2) do |jd|
      days_string += jd.day.to_s
    end
    days_string.should == "101214161820"

    days_string = ""
    jdate.upto(jdate+5) do |jd|
      days_string += jd.day.to_s
    end
    days_string.should == "101112131415"

    days_string = ""
    jdate.downto(jdate-5) do |jd|
      days_string += jd.day.to_s
    end
    days_string.should == "1098765"
  end

  it "should return a correct year day based on Jalali Calendar" do
    JalaliDate.new(1388,1,1).yday.should == 1
    JalaliDate.new(1388,12,29).yday.should == 365
    JalaliDate.new(1387,12,30).yday.should == 366
    JalaliDate.new(1388,9,17).yday.should == 263
  end

  it "should be able to print jalali date in different formats" do
    JalaliDate.new(1388,1,7).strftime("%a %A %b %B %d %e %j %m %w %y %Y %% %x").should == "ج  جمعه فروردین Farvardin 07 7 7 1 5 88 1388 % 88/1/7"
  end

  it "should be intialize with a time object" do
    time = Time.now
    JalaliDate.new(time).hour.should == time.hour
  end

  it "should be able for format %H %I %M %p %S %X %Z correctly if initiallized with time" do
    JalaliDate.new(1388,2,15,5,50,10).strftime("%H").should == "05"
    JalaliDate.new(1388,2,15,18,50,10).strftime("%H %I").should == "18 06"
    JalaliDate.new(1388,2,15,12,50,10).strftime("%H %I").should == "12 00"
    JalaliDate.new(1388,2,15,12,50,10).strftime("%H %I %M %S").should == "12 00 50 10"
    JalaliDate.new(1388,2,15,5,50,10).strftime("%p").should == "قبل از ظهر"
    JalaliDate.new(1388,2,15,15,50,10).strftime("%p").should == "بعد از ظهر"
    JalaliDate.new(1388,2,15,15,50,10).strftime("%X").should == "15:50:10"
    JalaliDate.new(1388,2,15,15,50,10).strftime("%X").should == "15:50:10"
    JalaliDate.new(1388,2,15,15,50,10,"CET",3600).strftime("%Z").should == "CET"
    time = Time.now
    JalaliDate.new(time).strftime("%Z").should == time.zone
  end

end