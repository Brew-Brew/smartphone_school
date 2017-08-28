class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :name
      t.string :lecture
      t.integer :score
      t.integer :subject_num
      t.references :user, index: true, foreign_key: true
     
      t.timestamps null: false
    end
  end
end
