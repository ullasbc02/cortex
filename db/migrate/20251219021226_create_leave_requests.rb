class CreateLeaveRequests < ActiveRecord::Migration[8.1]
  def change
    create_table :leave_requests do |t|
      t.string :employee_name
      t.date :start_date
      t.date :end_date
      t.string :status, default: 'Pending'

      
      t.timestamps
    end
  end
end
