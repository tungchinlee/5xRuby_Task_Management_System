class Task < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :tags
  validates :name, presence: true
  validates :start_at, presence: true
  validates :end_at, presence: true
  validates :status, presence: true
  validates :priority, presence: true
  enum status:{
    pending: 0,
    working: 1,
    finished: 2
  }

  enum priority:{
    low: 0,
    high: 1
  }
end
