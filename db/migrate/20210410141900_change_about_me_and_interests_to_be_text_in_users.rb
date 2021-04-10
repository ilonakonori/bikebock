class ChangeAboutMeAndInterestsToBeTextInUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :about_me, :text
    change_column :users, :interests, :text
  end
end
