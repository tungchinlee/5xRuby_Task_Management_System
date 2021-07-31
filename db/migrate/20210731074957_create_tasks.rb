class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.integer :user_id
      t.string :name
      t.datetime :start_at
      t.datetime :end_at
      t.text :content
      t.integer :priority, default: 0
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
