# frozen_string_literal: true

FactoryBot.define do
  factory :task_list do
    sequence(:title) { |n| "Task list title #{n}" }
    open { false }
    favorite { false }

    association :user, factory: :user
  end
end
