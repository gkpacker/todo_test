FactoryBot.define do
  factory :task_list do
    title { "MyString" }
    public { false }
    favorite { false }
  end
end
