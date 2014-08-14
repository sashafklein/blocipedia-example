class Collaboration < ActiveRecord::Base
  belongs_to :wiki
  belongs_to :collaborator, class_name: 'User', foreign_key: 'user_id'
end
