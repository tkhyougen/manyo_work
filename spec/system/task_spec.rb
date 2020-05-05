require 'rails_helper'
RSpec.describe 'タスク一覧画面', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @task = FactoryBot.create(:task, user: @user)
    @second_task = FactoryBot.create(:second_task, user: @user)
    @label = FactoryBot.create(:label) #事前にラベル作成
    FactoryBot.create(:midlabel, task:@task, label:@label)
    visit new_session_path
    fill_in "session_email", with: "sample1@example.com"
    fill_in "session_password", with: "00000000"
    click_on "ログイン"
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
        visit tasks_path
        task_list = all(".narabi")
        expect(task_list[0]).to have_content "bbb"
        expect(task_list[1]).to have_content "aaa"
      end
    end

  #step5にて一部追加
  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存されること'do
         # new_task_pathにvisitする（タスク登録ページに遷移する）
         visit new_task_path
         # 「タスク名」というラベル名の入力欄と、「タスク詳細」というラベル名の入力欄に
         # タスクのタイトルと内容をそれぞれfill_in（入力）する
         fill_in "task[name]", with: "222 タスク名"
         fill_in "task[detail]",with: "222 内容"
         check "テスト用ラベル"
         click_on "登録する"
          #（タスクが登録されたらタスク登録確認画面に遷移されるという前提で
         expect(page).to have_content("222 タスク名")
         expect(page).to have_content("テスト用ラベル")
      end
    end
  end

  describe 'タスク詳細画面' do
     context '任意のタスク詳細画面に遷移した場合' do
        it '該当タスクの内容が表示されたページに遷移すること'do
          task_a= FactoryBot.create(:task, name:"abab", detail:"abab", user: @user)
          visit task_path(task_a.id)
          # click_on "Show", href: task_path(task_a.id)
          # href="/tasks/17"
          expect(page).to have_content("abab")
        end
     end
  end

  describe 'タスク一覧画面' do
    context '終了期限でソートするを押した場合' do
      it '降順でソート'do
        visit tasks_path
        click_on "終了期限で降順にソート"
        task_list = all(".narabi")
        sleep 2.0
        expect(task_list[0]).to have_content "2020"
      end
    end
    context '優先度高い順でソートするを押した場合' do
      it '優先度高い順でソート'do
        visit tasks_path
        click_on "優先度高い順でソート"
        task_list = all(".narabi") #タスク一覧を配列として取得
        sleep 4.0
        expect(task_list[0]).to have_content "高"
      end
    end

    #step5にて追加
    context "ラベル絞込で検索をかけた場合" do
      it "ラベル「その他」でタスクが絞られる" do
        visit tasks_path
        select "テスト用ラベル", from:"search[label_id]"
        click_on "検索"
        task_list = all(".narabi") #タスク一覧を配列として取得
        sleep 4.0
        expect(task_list[0]).to have_content "テスト用ラベル"
      end
    end


  end

end
