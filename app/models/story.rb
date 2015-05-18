class Story < ActiveRecord::Base
  has_many :contributions
  has_one :location, as: :locatable  # also works for belongs_to associations
  acts_as_mappable through: :location

  def add_contribution(contribution)
    self.contributions << contribution
  end

  def completed?
    self.contributions.length >= self.contribution_limit
  end

  def complete!
    self.completed = true
    self.save
  end

  def as_json(options={})
    {
      id: self.id,
      contribution_limit: self.contribution_limit,
      contribution_length: self.contributions.length,
      last_contribution: self.contributions.last,
      title: self.title.to_json,
      lat: self.location.lat.to_json,
      lng: self.location.lng.to_json
    }
  end

end
