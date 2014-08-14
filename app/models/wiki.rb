class Wiki < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  has_many :collaborations
  has_many :collaborators, through: :collaborations, source: :collaborator
end
