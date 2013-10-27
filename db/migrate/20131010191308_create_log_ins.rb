class CreateLogIns < ActiveRecord::Migration
  def change
    create_table :log_ins do |t|

      t.timestamps
    end
  end
end
