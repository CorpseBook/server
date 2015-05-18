class Contribution < ActiveRecord::Base
  # belongs_to :user
  belongs_to :story

  def as_json(options={})
    {
      story_id: self.story_id,
      content: self.content,
      username: self.username
    }
  end
end
