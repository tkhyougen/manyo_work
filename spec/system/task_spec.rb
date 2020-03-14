require 'rails_helper'
RSpec.describe 'タスク一覧画面', type: :system do
  before do
    FactoryBot.create(:task, name:"aaa",detail:"aaaa")

  end

  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示されること'do
         visit tasks_path
         current_path
         Task.count
         expect(page).to have_content "aaa"
      end
    end
  end

    context '複数のタスクを作成した場合' do
      it 'タスクが作成日時の降順に並んでいること' do
        FactoryBot.create(:second_task, name:"bbb",detail:"bbbb")
        visit tasks_path
        task_list = page.all("td")
        expect(task_list[0]).to have_content "bbb"
        expect(task_list[1]).to have_content "bbbb"
      end
    end



  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存されること'do
         # new_task_pathにvisitする（タスク登録ページに遷移する）
         visit new_task_path
         # 「タスク名」というラベル名の入力欄と、「タスク詳細」というラベル名の入力欄に
         # タスクのタイトルと内容をそれぞれfill_in（入力）する
         fill_in "task[name]", with: "222 タスク名"
         fill_in "task[detail]",with: "222 内容"
         click_on "登録する"
          #（タスクが登録されたらタスク詳細画面に遷移されるという前提）
         expect(page).to have_content("222 タスク名")
      end
    end
  end

  describe 'タスク詳細画面' do
     context '任意のタスク詳細画面に遷移した場合' do
        it '該当タスクの内容が表示されたページに遷移すること'do
          task_a= FactoryBot.create(:task, name:"abab", detail:"abab")
          visit task_path(task_a.id)
          # click_on "Show", href: task_path(task_a.id)
          # href="/tasks/17"
          expect(page).to have_content("abab")
        end
     end
  end
end
