class AddDefaultValueToCompletedTodo < ActiveRecord::Migration
  def change
    change_column_default :todos, :completed, false
  end
end
