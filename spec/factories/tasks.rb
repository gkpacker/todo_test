# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    sequence(:title) { |n| "Task #{n}" }
    description { 'Awesome task description' }
    done { false }

    trait :invalid do
      title { nil }
    end

    association :task_list, factory: :task_list
  end
end
