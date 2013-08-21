class Review < ActiveRecord::Base
  POTATOES = (1..5).to_a
  belongs_to :movie
  belongs_to :moviegoer

  self.per_page = 10

  validates :movie_id, presence: true
  validates :moviegoer_id, presence: true
  validates :potatoes, inclusion: POTATOES
end
