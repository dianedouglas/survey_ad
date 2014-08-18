class CreateQuestion < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.column :name, :string
      t.column :survey_id, :int
    end
  end
end
