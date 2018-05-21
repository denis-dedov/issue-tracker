class CreateIssues < ActiveRecord::Migration[5.2]
  def change
    create_table :issues do |t|
      t.belongs_to :owner, index: true
      t.belongs_to :assignee, index: true
      t.string :title
      t.text :description
      t.string :status
      t.datetime :updated_at

      t.timestamps
    end
  end
end
