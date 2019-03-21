# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# 1.times do |n|###前のコードを参考に直してみてくださいbyまや
#   User.create!(
#     name: "test2",
#     email: "test2@example.com",
#     password_digest: "testdayo2"
#   )
# end

User.create!(
    name: "shibao",
    email: "shibao@example.com",
    password: "shibaodayo",
    admin: 'true'
)

10.times do |n|
  User.create!(
    name: "#{n}yamada",
    email: "#{n}yamada@example.com",
    password: "#{n}yamadadayo"
  )
end

10.times do |i|
  Task.create!(
    title: "タスク#{i}",
    content: "タスク内容#{i}",
    time_limit: "2019-03-20",
    user_id: 3 ####ここはseedでできるUserにしてくださいbyまや
  )
end

# 100.times do |n|
#   User.create!(
#     name: "#{n}yamada",
#     email: "#{n}yamada@example.com",
#     password_digest: "#{n}yamadadayo"
#   )
# end
