class LeaveRequestsController < ApplicationController
  def index
    @leave_requests = LeaveRequest.order(created_at: :desc)
  end

  def new
    @leave_request = LeaveRequest.new
  end

  def create
    @leave_request = LeaveRequest.new(leave_request_params)

    if @leave_request.save
      redirect_to leave_requests_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def leave_request_params
    params.require(:leave_request)
          .permit(:employee_name, :start_date, :end_date)
  end
end
