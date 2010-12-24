require "../jalalidate"

module Jalalidate
  class Cli
    
    
    def self.jdate(*args)
      p args
      jdate = JalaliDate.new(Date.today)
      puts jdate
    end

    
  
  end
end