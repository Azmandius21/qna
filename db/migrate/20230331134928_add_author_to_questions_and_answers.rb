class AddAuthorToQuestionsAndAnswers < ActiveRecord::Migration[6.1]
  def change
    change_table :questions do |t|
      t.belongs_to :author, null: false, foreign_key: { to_table: :users }
    end

    change_table :answers do |t|
      t.belongs_to :author, null: false, foreign_key: { to_table: :users }
    end
  end
end
