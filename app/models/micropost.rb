# == Schema Information
#
# Table name: microposts
#
#  id               :integer          not null, primary key
#  content          :string(255)
#  user_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  title            :string(255)
#  post_type        :string(255)
#  publication_name :string(255)
#  year             :integer
#  month            :integer
#  notes            :string(255)
#

class Micropost < ActiveRecord::Base
  attr_accessible :title, :post_type, :publication_name, :month, :year, :content
  belongs_to :user

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 80 }
  validates :post_type, presence: true, :inclusion => { :in => ["journal", "conference"] }
  validates :publication_name, presence: true, length: { maximum: 80 }
  validates :month, presence: true,  :numericality => { :greater_than => 0, :less_than_or_equal_to => 12 }
  validates :year, presence: true, :numericality => {:only_integer => true}, :numericality => { :greater_than => 1949, :less_than_or_equal_to => 3000 }
  validates :content, presence: true, length: { maximum: 140 }

  default_scope order: 'microposts.created_at DESC'

  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", 
          user_id: user.id)
  end
end
