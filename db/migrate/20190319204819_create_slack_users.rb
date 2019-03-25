class CreateSlackUsers < ActiveRecord::Migration[5.2]
  def self.up
    create_table :slack_users do |t|
      t.string :slack_id
      t.string :team_id
      t.string :real_name
      t.string :display_name
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :image_original
      t.boolean :is_custom_image
      t.timestamps
    end
  end

  def self.down
    drop_table :slack_users
  end
end
