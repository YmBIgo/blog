class Message < ActiveRecord::Base

  # association
  belongs_to :venture
  belongs_to :mentor

  # validation
  validates_presence_of :content, :venture_id, :mentor_id

end
