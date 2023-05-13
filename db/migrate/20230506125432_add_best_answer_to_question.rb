class AddBestAnswerToQuestion < ActiveRecord::Migration[6.1]
  def change
    change_table :questions do |t|
      t.belongs_to :best_answer, foreign_key: { to_table: :answers }
    end
  end
end
