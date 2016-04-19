class ShiftJobsController < ApplicationController
  before_action :set_shift_job, only: [:edit, :update, :destroy]
  # before_action :set_assignment, only: [:show, :edit, :update, :destroy]

  def index
   
  end

  def new
    @shift_job = ShiftJob.new

  end

  def edit
  end

  def create
    @shift_job = ShiftJob.new(shift_job_params)
    
    if @shift_job.save
      redirect_to shift_path(@shift_job.shift), notice: "#{@shift_job.job.name} is assigned to #{@shift_job.assignment.employee.proper_name}'s shift."
      # redirect_to assignment_path(@assignment), notice: "#{@assignment.employee.proper_name} is assigned to #{@assignment.store.name}."
    else
      render action: 'new'
    end
  end

  def update
    if @shift_job.update(shift_job_params)
      redirect_to shift_path(@shift_job.shift), notice: "#{@shift_job.job.name}'s assignment to #{@shift_job.assignment.employee.proper_name} is updated."
    else
      render action: 'edit'
    end
  end

  def destroy
    @shift_job.destroy
    redirect_to shifts_path, notice: "Successfully removed #{@shift_job.job.name} from #{@shift_job.assignment.employee.proper_name}'s shift."
  end

  private
  def set_shift_job
    @shift_job = ShiftJob.find(params[:id])
  end

  def shift_job_params
    params.require(:shift_job).permit(:job_id, :shift_id)
  end

end