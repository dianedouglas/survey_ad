class CreateSurvey < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.column :name, :string
    end
  end
end
