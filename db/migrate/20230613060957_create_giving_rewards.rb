class CreateGivingRewards < ActiveRecord::Migration[6.1]
  def change
    create_table :giving_rewards do |t|
      t.belongs_to :user, null: false
      t.belongs_to :reward, null: false
      t.timestamps
    end
  end
end
