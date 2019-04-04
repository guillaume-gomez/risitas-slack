class CreateSlackCredentials < ActiveRecord::Migration[5.2]
  def self.up
    create_table :slack_credentials do |t|
      t.string :confirmation_token
      t.datetime :confirmation_token_date
      t.string :team_id
      t.timestamps
    end
  end

  def self.down
    drop_table :slack_credentials
  end
end
