require 'rails_helper'

RSpec.describe 'Api::Comments', type: :request do
  
  # 変数の定義とインスタンスの生成
  let!(:user) { create(:user) }
  let!(:article) { create(:article, user: user) }
  let!(:comments) { create_list(:comment, 3, article: article)}

  describe "GET /api/comments" do
    it '200ステータス' do

      # HTTPステータスの検証
      get api_comments_path(article_id: article.id)
      expect(response).to have_http_status(200)

      # レスポンスの内容を検証
      body = JSON.parse(response.body)
      expect(body.length).to eq 3
      expect(body[0]['content']).to eq comments.first.content
      expect(body[1]['content']).to eq comments.second.content
      expect(body[2]['content']).to eq comments.third.content
    end
  end
end
