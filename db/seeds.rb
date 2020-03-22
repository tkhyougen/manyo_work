#
# 5.times do |n|
#
#   2.times do |n|
#     name = Faker::Pokemon.name
#     detail = Faker::Pokemon.name
#     due = Faker::Date.between(2.days.ago, Date.today)
#     status = Faker::Number.between(1, 3)
#     Task.create!(name: name,
#                  detail: detail,
#                  due: due
#                  )
#   end

1.times do |n|
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = "password"
  User.create!(name: name,
                email: email,
              password_digest: password
              )
end
