class CreateReqemails < ActiveRecord::Migration[5.0]
  def change
    create_table :reqemails do |t|
      t.string :email_digest

      t.timestamps
    end
  end
end
