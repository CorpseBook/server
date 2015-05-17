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

end
