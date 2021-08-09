class Task < ApplicationRecord
  paginates_per 3
  include AASM
  belongs_to :user, counter_cache: true
  has_and_belongs_to_many :tags
  validates :name, presence: true
  validates :start_at, presence: true
  validates :end_at, presence: true
  validates :status, presence: true
  validates :priority, presence: true
  validate :end_at_is_after_start_at

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

  def self.tagged_with(name)
    Tag.find_by!(name: name).tasks
  end

  def tag_list=(names)
    self.tags = names.split(',').map do |item|
      Tag.where(name: item.strip).first_or_create!
    end
  end

  def end_at_is_after_start_at
    return if end_at.blank? || start_at.blank?
  
    if end_at < start_at
      errors.add(:end_at, "請設定在開始時間之後") 
    end 
  end
    
end
