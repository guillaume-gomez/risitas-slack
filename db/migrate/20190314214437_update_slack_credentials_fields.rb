class UpdateSlackCredentialsFields < ActiveRecord::Migration[5.2]
  def change
    add_column :slack_credentials, :bot_user_id, :string
    add_column :slack_credentials, :bot_access_token, :string
  end
end
