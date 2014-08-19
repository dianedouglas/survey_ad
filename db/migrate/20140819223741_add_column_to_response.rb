class AddColumnToResponse < ActiveRecord::Migration
  def change
    add_column :responses, :question_id, :int
  end
end
