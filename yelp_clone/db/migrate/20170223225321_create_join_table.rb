class CreateJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_join_table :users, :reviews do |t|
      t.references :user, foreign_key: true
      t.references :review, foreign_key: true
    end
  end
end
