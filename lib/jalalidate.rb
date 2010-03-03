# :title:Jalali Date #
require "jcode"
require "date"

class JalaliDate

  #:stopdoc:
  $KCODE = 'u'
  GDaysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  JDaysInMonth = [31, 31, 31, 31, 31, 31, 30, 30, 30, 30, 30, 29]
  PERSIAN_MONTH_NAMES = [nil, "فروردین","اردیبهشت","خرداد","تیر","مرداد","شهریور","مهر","آبان","آذر","دی","بهمن","اسفند"]
  PERSIAN_WEEKDAY_NAMES = ["یک‌شنبه","دوشنبه","سه‌شنبه","چهارشنبه","پنج‌شنبه","جمعه","شنبه"]
  PERSIAN_ABBR_WEEKDAY_NAMES = ["۱ش","۲ش","۳ش","۴ش","۵ش","ج","ش"]
  PERSIAN_MERIDIAN_INDICATOR = ["قبل از ظهر","بعد از ظهر"]
  PERSIAN_ABBR_MERIDIAN_INDICATOR = ["ق.ظ","ب.ظ"]
  #:startdoc:

  include Comparable

  attr_accessor :year,:month,:day
  attr_reader :g_year, :g_month, :g_day

  # Can be initialized in two ways:
  # - First by feeding 3 arguments for Jalali Date, year,month and day.
  # - The Second way to initializes is to pass a normal Ruby Date object, it'll be converted to jalali automatically.
  # 
  # Example:
  #   jdate = JalaliDate.new(Date.today)
  #   other_jdate = JalaliDate.new(1388,9,17)
  def initialize *args
    if (args.size == 1) && (args.first.is_a? Date)
      year,month,day = gregorian_to_jalali(args.first.year, args.first.month, args.first.day) 
    else 
      year,month,day = args
    end
    
    raise ArgumentError, "invalid arguments or invalid Jalali date" unless self.class.valid?(year,month,day) 
    @year = year
    @month = month
    @day = day
    @g_year, @g_month, @g_day = jalali_to_gregorian(year,month,day)
  end

  # Class Methods -----------------------------------------------------------
  class << self   
    # Return a JalaliDate object representing today's date in calendar
    def today
      JalaliDate.new(Date.today)
    end

    # Return a JalaliDate object representing yesterday's date in calendar
    def yesterday
      JalaliDate.new(Date.today - 1)
    end

    # Return a JalaliDate object representing tomorrow's date in calendar
    def tomorrow  
      JalaliDate.new(Date.today + 1)
    end

    # Accpets a four digit number as the jalaliyear and returns true if that particular year 
    # is a leap year in jalali calendar otherwise it returns false.
    def leap?(y) 
      [6,22,17,13,9,5,1,30].include?(y%33) ? true : false 
    end

    # Accpets three numbers for year (4 digit), month and day in jalali calendar and checks if it's a 
    # valid date according to jalali calendar or not.
    def valid?(y,m,d)
      ( y.class == Fixnum && y > 0 &&
        m.class == Fixnum && (1..12).include?(m) &&
        d.class == Fixnum &&
        ( 
          ((1..JDaysInMonth[m-1]).include?(d)) || (d == 30 && m == 12 && leap?(y))
        ) 
      ) ? true : false
    end
  end

  # Instance Methods --------------------------------------------------------
  
  # Converts a JalaiDate object to Ruby Date object
  def to_gregorian 
    Date.new(@g_year,@g_month,@g_day)
  end
  alias :to_g :to_gregorian

  # Returns a string represtation of the JalaliDate object in format like this: y/m/d
  def to_s 
    [@year,@month,@day].join("/") 
  end

  # Returns a hash in a format like this: {:year => @year, :month => @month, :day => @day}
  def to_hash
    {:year => @year, :month => @month, :day => @day}
  end

  # Returns an array in a format like this: [y,m,d]
  def to_a
    [@year,@month,@day]
  end

  # Return internal object state as a programmer-readable string. 
  def inspect
    "#<#{self.class}:#{self.object_id}, :year => #{@year}, :month => #{@month}, :day => #{@day} >" 
  end

  # Adds n days to the current JalaliDate object
  def +(days)
    self.class.new( to_g + days )
  end
  
  # Subtracts n days from the current JalaliDate object
  def -(days)
    self.class.new( to_g - days )
  end
  
  # Return the next day for the current JalaliDate object
  def next(n=1)
    self + n 
  end
  alias :succ :next
  
  # Return the previous day for the current JalaliDate object
  def previous(n=1) 
    self - n 
  end  
  
  # Compares two JalaliDate objects. acts like Date#<=>
  def <=>(other)
    to_g <=> other.to_g  
  end

  # Move JalaliDate object forward by n months
  def >>(months)
    y, m = (@year * 12 + (@month - 1) + months).divmod(12)
    m,   = (m + 1)                    .divmod(1)
    d = @day
    d -= 1 until self.class.valid?(y, m, d)
    self.class.new(y,m,d)
  end
  
  # Move JalaliDate object backward by n months 
  def <<(months)
    self >> -months
  end
  
  # Step the current date forward +step+ days at a time (or backward, if step is negative) until we reach 
  # limit (inclusive), yielding the resultant date at each step.
  #
  # Example:
  #   jdate = JalaliDate.new(Date.today)
  #   jdate.step(Date.today+10, 2) do |jd|
  #     puts jd.to_s
  #   end
  def step(limit, step=1) 
    da = self
    op = %w(- <= >=)[step <=> 0]
    while da.__send__(op, limit)
      yield da
      da += step
    end
    self
  end
  
  # Step forward one day at a time until we reach max (inclusive), yielding each date as we go.
  #
  # Example:
  #   jdate = JalaliDate.new(Date.today)
  #   days_string = ""
  #   jdate.upto(jdate+5) do |jd|
  #     days_string += jd.day.to_s
  #   end
  def upto(max, &block)
    step(max, +1, &block)
  end

  # Step backward one day at a time until we reach min (inclusive), yielding each date as we go. 
  # See #upto for the example.
  def downto(min, &block)
    step(min, -1, &block)
  end

  # Is this a leap year?
  def leap?
    self.class.leap?(@year)
  end

  # Get the week day of this date. Sunday is day-of-week 0; Saturday is day-of-week 6.
  def wday
    to_g.wday
  end

  # Get the day-of-the-year of this date.
  # Farvardin 1 is day-of-the-year 1
  def yday
    m = (@month-2 < 0) ? 0 : @month-2
    (@month==1) ? @day : @day + JDaysInMonth[0..m].inject(0) {|sum, n| sum + n } 
  end  
  
  # Formats time according to the directives in the given format string. Any text not listed as a directive will be 
  # passed through to the output string.
  #
  # Format meanings:
  #
  # [%a]  The abbreviated weekday name (۳ش)
  # [%A]  The full weekday name (یکشنبه)
  # [%b or %B]   The month name (اردیبهشت)
  # [%d]   Day of the month (1..31)
  # [%j]   Day of the year (1..366)
  # [%m]   Month of the year (1..12)
  # [%w]   Day of the week (Sunday is 0, 0..6)
  # [%x]   Preferred representation for the date alone, no time in format YY/M/D
  # [%y]   Year without a century (00..99)
  # [%Y]   Year with century
  # [%%]   Literal %'' character
  # 
  # Example:
  #   d = JalaliDate.today
  #   d.strftime("Printed on %Y/%m/%d")   #=> "Printed on 87/5/26
  def strftime(format_str = '%Y/%m/%d')
    clean_fmt = format_str.gsub(/%{2}/, "SUBSTITUTION_MARKER").
      gsub(/%a/, PERSIAN_ABBR_WEEKDAY_NAMES[wday]).
      gsub(/%A/, PERSIAN_WEEKDAY_NAMES[wday]).
      gsub(/%b/, PERSIAN_MONTH_NAMES[@month]).
      gsub(/%B/, PERSIAN_MONTH_NAMES[@month]).
      gsub(/%d/, @day.to_s).
      gsub(/%m/, @month.to_s).
      gsub(/%Y/, @year.to_s).
      gsub(/%y/, @year.to_s.slice(2,2)).
      gsub(/%j/, yday.to_s).
      gsub(/%w/, wday.to_s).
      gsub(/%x/, [@year.to_s.slice(2,2),@month,@day].join("/")).
      gsub(/#{"SUBSTITUTION_MARKER"}/, '%')
  end    
  alias :format :strftime
  
  private #-------------------------------------------------------------------------

  def gregorian_to_jalali(year, month, day)
    gy = year - 1600
    gm = month - 1
    gd = day - 1
    g_day_no = 365*gy + (gy+3)/4 - (gy+99)/100 + (gy+399)/400
    gm.times { |i| g_day_no += GDaysInMonth[i] }
    g_day_no += 1 if gm > 1 && ((gy%4 == 0 && gy%100 != 0) || (gy%400 == 0))
    g_day_no += gd
  
    j_day_no = g_day_no-79
    j_np = j_day_no/12053
    j_day_no %= 12053
    jy = 979 + 33 * j_np + 4*(j_day_no/1461)
    j_day_no %= 1461
  
    if (j_day_no >= 366)
       jy += (j_day_no - 1)/365
       j_day_no = (j_day_no - 1) % 365
    end
  
    11.times do |i|
      if j_day_no >= JDaysInMonth[i]
        j_day_no -= JDaysInMonth[i]
        $j = i + 1
      else
        $j = i
        break
      end
    end
    jm = $j + 1
    jd = j_day_no + 1
  
    [jy, jm, jd]
  end
  
  def jalali_to_gregorian(year,month,day)
    jy = year - 979
    jm = month - 1
    jd = day - 1
    j_day_no = 365*jy + (jy/33)*8 + (jy % 33 + 3)/4
    jm.times { |i| j_day_no += JDaysInMonth[i] }
    j_day_no += jd
    
    g_day_no = j_day_no + 79
    gy = 1600 + 400*(g_day_no/146097)
    g_day_no %= 146097
    
    leap = true
    if g_day_no >= 36525 
      g_day_no -= 1
      gy += 100 * (g_day_no/36524)
      g_day_no %= 36524   
      (g_day_no >= 365) ? g_day_no += 1 : leap = false
    end
    
    gy += 4 * (g_day_no/1461)
    g_day_no %= 1461
    
    if g_day_no >= 366
      leap = false
      g_day_no -= 1
      gy += g_day_no/365
      g_day_no %= 365
    end

    11.times do |i|
      leap_day = (i==1 && leap) ?  1 : 0
      if g_day_no >= (GDaysInMonth[i] + leap_day )
        g_day_no -= (GDaysInMonth[i] + leap_day )
        $g = i + 1
      else
        $g = i
        break
      end
    end
    gm = $g + 1 
    gd = g_day_no + 1
    
    [gy,gm,gd]
  end

end