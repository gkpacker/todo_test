# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :task_list

  validates :title, presence: true

  def done!
    update(done: true)
  end

  def pending!
    update(done: false)
  end
end
