class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :owned_wikis, class_name: 'Wiki', foreign_key: 'owner_id'
  has_many :collaborations
  has_many :collaborated_wikis, through: :collaborations, source: :wiki
end
