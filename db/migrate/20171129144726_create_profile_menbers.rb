class CreateProfileMenbers < ActiveRecord::Migration
  def change
    create_table :profile_menbers do |t|
      t.string :first_name
      t.string :last_name
      t.date :birthdate
      t.references :member, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
