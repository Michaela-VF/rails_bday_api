class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.date :dob, null: false

      t.timestamps
    end

    add_check_constraint :users,
      "dob <= CURRENT_DATE",
      name: "users_dob_not_future"
  end
end
