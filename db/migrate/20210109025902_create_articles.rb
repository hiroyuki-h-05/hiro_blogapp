class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.references :user, null: false  # 関連付け
      t.string :title, null: false
      t.text :content, null: false
      t.timestamps  # データ作成日のカラム
    end
  end
end
