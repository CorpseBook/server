FactoryGirl.define do
  factory :story do
    title "Title"
    contribution_limit 10
    completed false
    location
  end

  factory :completed_story, class: Story do
    title "Title"
    contribution_limit 10
    completed true
    location
  end

end
