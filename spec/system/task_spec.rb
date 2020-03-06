require 'rails_helper'
RSpec.describe 'タスク一覧画面', type: :system do
  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示されること'do
       task = FactoryBot.create(:task, name:"111")
       visit tasks_path
       Task.count
       expect(page).to have_content "111"
      end
    end
  end
  # describe 'タスク登録画面' do
  #   context '必要項目を入力して、createボタンを押した場合' do
  #     it 'データが保存されること'do
  #     # new_task_pathにvisitする（タスク登録ページに遷移する）
  #     visit new_task_path
  #     # 「タスク名」というラベル名の入力欄と、「タスク詳細」
  #     というラベル名の入力欄に
  #     # タスクのタイトルと内容をそれぞれfill_in（入力）する
  #     fill_in "タスク名", with: "222 タスク名"
  #     fill_in "内容" ,with: "222 内容"
  # 　# 「登録する」というvalue（表記文字）のあるボタンをclick_onする（クリックする）
  #     click_button "登録する"
  #     expect(page).to have_content("222 タスク名")
  #     #（タスクが登録されたらタスク詳細画面に遷移されるという前提）
  #     end
  #   end
  # end
  # describe 'タスク詳細画面' do
  #    context '任意のタスク詳細画面に遷移した場合' do
  #       it '該当タスクの内容が表示されたページに遷移すること'
  #       task_a= FactoryBot.create(:task, name:"333", content:"3333")
  #       visit task_path(task_a)
  #       expect(page).to have_content("333")
  #       end
  #    end
  # end
end
