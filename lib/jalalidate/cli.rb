module Jalalidate
  class Cli

    # prints today's date in jalali calendar to STDOUT
    #
    def self.jdate(*args)
      jdate = JalaliDate.new(Date.today)
      puts jdate
    end

    # prints current month calendar in jalali calendar to STDOUT
    #
    def self.jcal(*args)
      today = JalaliDate.new(Date.today)
      jdate = JalaliDate.new(today.year,today.month,1)
      # print month and year
      puts jdate.strftime("%b %Y").center(26)
      # print weekdays
      puts JalaliDate::PERSIAN_ABBR_WEEKDAY_NAMES.reverse[1..6].join("  ") +  " " +  JalaliDate::PERSIAN_ABBR_WEEKDAY_NAMES.reverse[0] + " "
      # print the month days
      padding = true
      JalaliDate::JDaysInMonth[jdate.month - 1].times do |index|
        if padding
          print " " * (jdate.jwday*4)
          padding = false
        end
        print "%2d" % jdate.day + "  "
        print "\n"  if jdate.jwday == 6
        jdate = jdate.next
      end

      puts "\n"
    end

  end
end