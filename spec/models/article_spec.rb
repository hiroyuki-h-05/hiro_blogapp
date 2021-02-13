require 'rails_helper'

RSpec.describe Article, type: :model do

  # letの引数は変数名、createの引数はfactoryで設定した名前
  # let!(:user) { create(:user, email: 'test@test.com') } 値を書き換えたい場合
  let!(:user) { create(:user) }

  context 'タイトルと内容が入力されている場合' do
    let!(:article) { build(:article, user: user) }

    it '記事を保存できる' do
      expect(article).to be_valid
    end
  end

  context 'タイトルの文字が1文字の場合' do
    let!(:article) { build(:article, title: Faker::Lorem.characters(number: 1), user: user) }

    before do
      article.save
    end

    it '記事を保存できない' do
      expect(article.errors.messages[:title][0]).to eq('は2文字以上で入力してください')
    end
  end
end