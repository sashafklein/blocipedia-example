class Wiki < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  has_many :collaborations
  has_many :collaborators, through: :collaborations, source: :collaborator

  extend FriendlyId
  friendly_id :title, use: :slugged

  def public
    !self.private
  end

  def markdown_body
    renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
    renderer.render body
  end
end
