FactoryGirl.define do
  factory :location do
  	lat -41.288889
  	lng 174.777222    
  end

  factory :wellington, class: Location do
  	lat -41.288889
  	lng 174.777222
  end

  factory :auckland, class: Location do
  	lat -36.840556 
  	lng 174.74
  end

  factory :nelson, class: Location do
  	lat -41.270833
  	lng 173.283889
  end

  factory :new_york, class: Location do
  	lat 40.7127
  	lng -74.0059
  end

end
