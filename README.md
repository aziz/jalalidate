# Jalali Date Library

## Install

    $ gem install jalalidate

## Tests
Simply run `rspec` command in the source directory:

    $ rspec

## Format meanings:

- `[%a]` The abbreviated weekday name (۳ش)
- `[%A]` The full weekday name (یکشنبه)
- `[%b]` The month name (اردیبهشت)
- `[%B]` The month name in pinglish (Ordibehesht)
- `[%d]` Day of the month (01..31)
- `[%e]` Day of the month (1..31)
- `[%j]` Day of the year (1..366)
- `[%m]` Month of the year (1..12)
- `[%n]` Month of the year (01..12)
- `[%w]` Day of the week (Sunday is 0, 0..6)
- `[%x]` Preferred representation for the date alone, no time in format YY/M/D
- `[%y]` Year without a century (00..99)
- `[%Y]` Year with century
- `[%H]` Hour of the day, 24-hour clock (00..23)
- `[%I]` Hour of the day, 12-hour clock (01..12)
- `[%M]` Minute of the hour (00..59)
- `[%p]` Meridian indicator ("بعد از ظهر" or "قبل از ظهر")
- `[%P]` Meridian indicator ("ب.ظ" or "ق.ظ")
- `[%S]` Second of the minute (00..60)
- `[%X]` Preferred representation for the time alone, no date
- `[%Z]` Time zone name
- `[%%]` teral %'' character

## History

#### 0.3.3 - 17.SEP.2013
* added %n formatter for numeric representation of a month, with leading zeros, courtesy of [Mohsen Alizadeh](https://github.com/m0h3n)

#### 0.3.2 - 8.APR.2013
* Making JalaliDate class thread safe, courtesy of [Jahangir Zinedine](https://github.com/jzinedine)

#### 0.3.1 - 26.APR.2011
* Added ruby 1.9 compatibility, courtesy of [Reza](https://github.com/ryco)

#### 0.3 - 6.JAN.2011
* JalaiDate could be initialized with Time and DateTime objects
* More options for strftime method %H,%M,%S,%X,%Z,%I,%p. read docs for more information
* Added jdate and jcal binaries to access jcal from the command-line
* Updated some documentations
* Now using bundler

#### 0.2 - 25.FEB.2010
* Renamed the gem from JalaliDate to jalalidate
* Added spec and a full test suite
* Updated gemspec file for rubygems.org
* Updated some documentations

#### 0.02 - 8.AUG.2008
* Added jalali to geregorian date convertor.
* Added JalaliDate class and ported Date class method to JalaliDate

#### 0.01 - 7.AUG.2008
* Planning the project


## Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2008-2011 Allen A. Bargi. See LICENSE for details.
