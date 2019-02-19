class Movie < ActiveRecord::Base
    
    def self.getRatings
        return  self.uniq.pluck(:rating)
    end
end
