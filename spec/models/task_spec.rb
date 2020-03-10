require 'rails_helper'

RSpec.describe "タスク管理機能", type: :model do
  it "nameが空ならバリデーションが通らない" do
    task = Task.new(name:"", detail:"失敗テスト",due:"2020-05-01")
    expect(task).not_to be_valid
  end

  it "detailが空ならバリデーションが通らない" do
    task1 = Task.new(name:"失敗テスト", detail:"",due:"2020-05-01")
    expect(task1).not_to be_valid
  end

  it "dueが空ならバリデーションが通らない"do
    task2 = Task.new(name:"", detail:"",due:"2020-05-01")
    expect(task2).not_to be_valid
  end

  it 'nameとdetailとdueに内容が記載されていればバリデーションが通る' do
    task2 = Task.new(name:"テスト", detail:"テスト",due:"2020-05-01")
    expect(task2).to be_valid
  end
end
