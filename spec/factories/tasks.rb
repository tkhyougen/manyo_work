FactoryBot.define do
  factory :task do
    name {"aaa"}
    detail {"aaaaaa"}
    due {"2020-08-01"}
    priority { 0 }
  end

  factory :second_task, class: Task do
    name {"bbb"}
    detail{"bbbbbb"}
    due {"2019-08-01"}
    priority { 0 }
  end
end
