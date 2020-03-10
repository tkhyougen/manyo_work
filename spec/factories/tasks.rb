FactoryBot.define do
  factory :task do
    name {"タイトルサンプル1"}
    detail {"詳細サンプル1"}
  end

  factory :second_task, class:Task do
    name {"タイトルサンプル2"}
    detail{"詳細サンプル2"}
  end
end
