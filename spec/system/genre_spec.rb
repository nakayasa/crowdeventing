# frozen_string_literal: true

require "rails_helper"

describe "投稿のテスト" do
  let!(:genre) { create(:genre, name: "hoge") }
  describe "トップ画面(root_path)のテスト" do
    before do
      visit root_path
    end
    context "表示の確認" do
      it "トップ画面(root_path)に「アタラシイ」が表示されているか" do
        expect(page).to have_content "アタラシイ"
      end
      it 'root_pathが"/"であるか' do
        expect(current_path).to eq("/")
      end
    end
  end


  describe "管理者ログインのテスト" do
    context "ログインの確認" do
      it "管理者権限でログインできるか" do
        @admin = FactoryBot.create(:admin)
        sign_in @admin
      end
    end
  end


  describe "ジャンル登録画面のテスト" do
    before do
      @admin = FactoryBot.create(:admin)
      sign_in @admin
      visit admin_genres_path
    end
    context "表示の確認" do
      it 'admin_genres_pathが"/admin/genres"であるか' do
        expect(current_path).to eq("/admin/genres")
      end
      it "新規登録ボタンが表示されているか" do
        expect(page).to have_button "新規登録"
      end
    end
    context "投稿処理のテスト" do
      it "投稿後のリダイレクト先は正しいか" do
        fill_in "genre[name]", with: Faker::Lorem.characters(number: 5)
        click_button "新規登録"
        expect(page).to have_current_path admin_genres_path
      end
    end
  end

  describe "投稿一覧のテスト" do
    before do
      @admin = FactoryBot.create(:admin)
      sign_in @admin
      visit admin_genres_path
    end
    context "表示の確認" do
      it "投稿されたものが表示されているか" do
        expect(page).to have_content genre.name
      end
    end
  end


  describe "詳細画面のテスト" do
     before do
       @admin = FactoryBot.create(:admin)
       sign_in @admin
       visit admin_genres_path
     end
     context "表示の確認" do
       it "編集リンクが存在しているか" do
         expect(page).to have_link "編集する"
       end
     end
   end

  describe "編集画面のテスト" do
    before do
      @admin = FactoryBot.create(:admin)
      sign_in @admin
      visit edit_admin_genre_path(genre)
    end
    context "表示の確認" do
      it "編集前の名前がフォームに表示(セット)されている" do
        expect(page).to have_field "genre[name]", with: genre.name
      end
      it "保存ボタンが表示される" do
        expect(page).to have_button "変更を保存"
      end
    end
    context "更新処理に関するテスト" do
      it "更新後のリダイレクト先は正しいか" do
        fill_in "genre[name]", with: Faker::Lorem.characters(number: 5)
        click_button "変更を保存"
        expect(page).to have_current_path admin_genres_path
      end
    end
  end
end
