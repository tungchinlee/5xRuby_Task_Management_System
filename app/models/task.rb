class Task < ApplicationRecord
  include AASM
  belongs_to :user
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
    middle: 1,
    high: 2
  }

  scope :order_start_at, -> { order(start_at: :desc) }

  aasm column: :status do
    state :pending, initial: true
    state :working, :finished

    event :working do
      transitions from: :pending, to: :working
    end

    event :finished do
      transitions from: [:pending, :working], to: :finished
    end
  end
end
