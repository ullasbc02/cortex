class CreateLeaveRequests < ActiveRecord::Migration[8.1]
  def change
    unless table_exists?(:leave_requests)
      create_table :leave_requests do |t|
        t.string :employee_name
        t.date :start_date
        t.date :end_date
        t.string :status, default: 'Pending'

        t.timestamps
      end
    end
  end
end
