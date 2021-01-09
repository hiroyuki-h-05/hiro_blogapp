class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|

      # string : 短い文字列,  text : 長い文字列
      t.string :title
      t.text :content

      # データ作成日のカラム
      t.timestamps
    end
  end
end
