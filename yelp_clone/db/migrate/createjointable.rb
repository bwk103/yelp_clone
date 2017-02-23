class CreateReviewedRestaurantsJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_join_table :restaurants, :reviews do |t|
      t.index :assembly_id
      t.index :part_id
    end
  end
end
