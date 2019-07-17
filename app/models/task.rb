# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :task_list

  validates :title, presence: true
end
