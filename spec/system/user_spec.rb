# - ユーザ登録のテスト
#   - ユーザの新規登録ができること
#   - ユーザがログインしていないのにタスク一覧のページに飛ぼうとした場合ログイン画面に遷移すること
# - セッション機能のテスト
#   - ログインができること
#   - 自分の詳細画面(マイページ)に飛べること
#   - 一般ユーザが他人の詳細画面に飛ぶとタスク一覧ページに遷移すること
#   - ログアウトができること
# - 管理画面のテスト
#   - 管理者は管理画面にアクセスできること
#   - 一般ユーザは管理画面にアクセスできないこと
#   - 管理者はユーザを新規登録できること
#   - 管理者はユーザの詳細画面にアクセスできること
#   - 管理者はユーザの編集画面からユーザを編集できること
#   - 管理者はユーザの削除をできること
require 'rails_helper'
RSpec.describe '​ユーザ登録・ログイン・ログアウト機能​・管理画面テスト', type: :system do

  describe '​ユーザ登録のテスト​' do
    context '​ユーザのデータがなくログインしていない場合​' do
      it '​ユーザ新規登録のテスト​' do
        visit new_user_path
        fill_in 'user_name', with: 'sample'
        fill_in 'user_email', with: 'sample@example.com'
        fill_in 'user_password', with: '00000000'
        fill_in 'user_password_confirmation', with: '00000000'
        click_on '登録する'
        expect(page).to have_content 'sample'
        # eq user_path(id: 1)
      end
      it '​ログインしていない時はログイン画面に飛ぶテスト​' do
        visit tasks_path
        expect(current_path).to eq new_session_path
      end
    end
  end

  describe "セッション機能のテスト" do
    before do
      @user = FactoryBot.create(:user)
    end
    context "ユーザーのデータがあってログインしていない場合" do
      it "ログインができること" do
        visit new_session_path
        fill_in 'session_email', with: @user.email
        fill_in 'session_password', with: @user.password
        # binding.pry
        click_on "ログイン"
        # sleep 2.0
        expect(current_path).to eq user_path(id: @user.id)
        # have_content("メールアドレス")
      end
    end

    context "ユーザーのデータがあってログインしている場合" do
      before do
        visit new_session_path
        fill_in "session_email", with: "sample1@example.com"
        fill_in "session_password", with: "00000000"
        click_on "ログイン"
      end

      it "自分の詳細画面(マイページ)に飛べること" do
        visit user_path(id: @user.id)
        expect(current_path).to eq user_path(id: @user.id)
      end

      it "一般ユーザが他人の詳細画面に飛ぶとタスク一覧ページに遷移すること" do
        @admin_user = FactoryBot.create(:admin_user)
        visit user_path(id: @admin_user.id)
        expect(page).to have_content "他の人のページへアクセスは出来ません"
      end

      it "ログアウトができること" do
        visit user_path(id: @user.id)
        click_on "Logout"
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content "ログアウトしました"
      end
    end
  end

  describe "管理画面のテスト" do
    context "アドミンユーザーがない場合" do
      it "管理者は管理画面にアクセスできること" do
        FactoryBot.create(:admin_user)
        visit new_session_path
        fill_in "session_email", with: "admin@example.com​"
        fill_in "session_password", with: "11111111"
        click_on "ログイン"
        visit admin_users_path
        expect(page).to have_content "管理画面"
      end
    end

    context "一般ユーザーでログインしている場合" do
      it "一般ユーザは管理画面にアクセスできないこと" do
        FactoryBot.create(:user)
        visit new_session_path
        fill_in "session_email", with: "sample1@example.com"
        fill_in "session_password", with: "00000000"
        click_on "ログイン"
        visit admin_users_path
        expect(page).to have_content "あなたは管理者ではありません"
      end
    end

    context "管理者でログインしている場合" do
      before do
        FactoryBot.create(:admin_user)
        visit new_session_path
        fill_in "session_email", with: "admin@example.com"
        fill_in "session_password", with: "11111111"
        click_on "ログイン"
        visit admin_users_path
      end

      it "管理者はユーザを新規登録できること" do
        sleep 2.0
        click_on "新規登録"
        fill_in "user_name", with: "111"
        fill_in "user_email", with: "111@example.com"
        fill_in "user_password", with: "111111"
        fill_in "user_password_confirmation", with: "111111"
        click_on "登録する"
        expect(page).to have_content "111"
      end

      it  "管理者はユーザの詳細画面にアクセスできること" do
        @user = FactoryBot.create(:user)
        visit admin_user_path(id: @user.id)
        expect(page).to have_content "sample1"
      end

      it "管理者はユーザの編集画面からユーザを編集できること" do
        @user = FactoryBot.create(:user)
        visit edit_admin_user_path(id: @user.id)
        fill_in 'user_name', with: 'sample2'
        fill_in 'user_email', with: 'sample2@example.com'
        fill_in 'user_password', with: '00000000'
        fill_in 'user_password_confirmation', with: '00000000'
        click_button '登録する'
        expect(page).to have_content "sample2"
      end

      it "管理者はユーザの削除をできること" do
        @user = FactoryBot.create(:user)
        visit admin_users_path
        click_on "削除", match: :first
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content "削除しました"
      end
    end
  end
end
