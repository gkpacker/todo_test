# frozen_string_literal: true

FactoryBot.define do
  factory :task_list do
    sequence(:title) { |n| "Task list title #{n}" }
    open { true }
    favorite { false }

    association :user, factory: :user

    trait :invalid do
      title { nil }
    end
  end
end
