# frozen_string_literal: true

class TaskList < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy

  validates :title, presence: true

  def favorite!
    update(favorite: true)
  end

  def unfavorite!
    update(favorite: false)
  end

  def open!
    update(open: true)
  end

  def close!
    update(open: false)
  end
end
