class CreateGivingRewards < ActiveRecord::Migration[6.1]
  def change
    create_table :giving_rewards do |t|

      t.timestamps
    end
  end
end
