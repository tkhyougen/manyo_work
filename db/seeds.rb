
priority_array=["高","中","低"]
status_array=["未着手","着手中","完了"]
3.times do |n|
    name = Faker::Games::Pokemon.name
    detail = Faker::Games::Pokemon.name
    due = Faker::Date.between(from: 2.days.ago,to: Date.today)
    priority = priority_array[rand(3)]  #enum
    status = status_array[rand(3)]
    Task.create!(name: name,
                 detail: detail,
                 due: due,
                 priority: priority,
                 status: status,
                 )
end

3.times do |n|
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
              )
end
