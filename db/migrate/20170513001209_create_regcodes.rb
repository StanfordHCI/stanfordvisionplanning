class CreateRegcodes < ActiveRecord::Migration[5.0]
  def change
    create_table :regcodes do |t|
      t.string :code_digest
      t.boolean :used, default: false

      t.timestamps
    end
  end
end
