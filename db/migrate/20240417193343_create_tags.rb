# frozen_string_literal: true

class CreateTags < ActiveRecord::Migration[7.1]
  def change
    create_table :tags do |t|
      t.string :title
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
