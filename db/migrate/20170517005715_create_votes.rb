class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.integer :value
      t.references :user, foreign_key: true
      t.references :idea, foreign_key: true

      t.timestamps
    end
    add_index :votes, [:idea_id, :created_at]
  end
end
