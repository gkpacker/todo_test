# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(email: Faker::Internet.email,
                   password: 'secret',
                   password_confirmation: 'secret')

user.task_lists.create!(title: 'My Private task list', open: false)

4.times do
  task_list_user = User.create(email: Faker::Internet.email,
                               password: 'secret',
                               password_confirmation: 'secret')

  task_list = TaskList.create(title: Faker::Lorem.word,
                              user: task_list_user,
                              open: true)

  5.times do
    Task.create(title: Faker::Lorem.word,
                description: Faker::Lorem.sentence,
                subtask: Faker::Lorem.sentence,
                task_list: task_list)
  end
end
