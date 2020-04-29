FactoryBot.define do
  factory :user do
    # id { 1 }
    name { '​sample​1' }
    email { 'sample1@example.com' }
    password { '00000000' }
    admin { false }
  end
  factory :admin_user, class: User do
    # id { 2 }
    name { '​admin​' }
    email { 'admin@example.com' }
    password { '11111111' }
    admin { true }
  end
end
