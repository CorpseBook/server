class Story < ActiveRecord::Base
  has_many :contributions, dependent: :destroy
  has_one :location, as: :locatable, dependent: :destroy
  # add test for dependent destroy
    # also works for belongs_to associations
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

  def contribution_length
    self.contributions.length
  end

  def last_contribution
    self.contributions.last
  end

  def first_contribution
    self.contributions.first
  end

  def all_contributions
    self.contributions
  end

end
