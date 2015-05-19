FactoryGirl.define do

  factory :location do
  	lat -41.288889
  	lng 174.777222
  end

  #home
  factory :EDA, class: Location do
  	lat -41.296837
  	lng 174.774194
  end

  # 1 k away
  factory :tepapa, class: Location do
  	lat -41.290446
  	lng 174.782248
  end

  # 4.5 km's away
  factory :karori_park, class: Location do
  	lat -41.283471
  	lng 174.723120
  end

  # 5.2 km's away
  factory :ngaio, class: Location do
  	lat -41.250440
  	lng 174.773674
  end

  # 11,328,12 km's away
  factory :madagascar, class: Location do
    lat -20.781929
    lng 45.993220
  end

end
