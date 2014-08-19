class CreateResponse < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.column :answer_id, :int
    end
  end
end
