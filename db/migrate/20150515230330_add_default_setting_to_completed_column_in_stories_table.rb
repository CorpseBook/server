class AddDefaultSettingToCompletedColumnInStoriesTable < ActiveRecord::Migration
  change_column_default :stories, :completed, false
end
