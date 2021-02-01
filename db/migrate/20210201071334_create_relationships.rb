class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.references :following, foreign_key: { to_table: :users }, null: false
      t.references :follower, foreign_key: { to_table: :users }, null: false
      t.timestamps
    end
  end
end
