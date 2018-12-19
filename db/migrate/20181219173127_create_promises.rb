class CreatePromises < ActiveRecord::Migration[5.2]
  def change
    create_table :promises do |t|
      t.string :promisee
      t.date :promise_start_date
      t.date :promise_end_date
      t.text :body
      t.integer :status

      t.timestamps
    end
  end
end
