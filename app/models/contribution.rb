class Contribution < ActiveRecord::Base
  # belongs_to :user
  belongs_to :story

  # Validations?

  # Test this method
  def as_json(options={})
    # self is a little redundent here
    # as this is a instance method
    # so Ruby implicitly will know that
    # story_id is an attribute on self
    {story_id: self.story_id, content: self.content}
  end
end
