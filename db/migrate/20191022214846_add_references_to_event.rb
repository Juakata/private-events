class AddReferencesToEvent < ActiveRecord::Migration[6.0]
  def change
    add_reference :events, :creator, index: true
  end
end
