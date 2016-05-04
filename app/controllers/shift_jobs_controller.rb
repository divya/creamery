class ShiftJobsController < ApplicationController
  before_action :set_shift_job, only: [:edit, :update, :destroy]
  # before_action :set_assignment, only: [:show, :edit, :update, :destroy]
  authorize_resource
  

  def index
   
  end

  def show
    
  end

  def new
    @shift_job = ShiftJob.new
    @remaining_jobs = Job.active 
  end

  def edit
  end

  def create
    @shift_job = ShiftJob.new(shift_job_params)

    respond_to do |format|
      if @shift_job.save
        @shift = @shift_job.shift
        @jobs = @shift.jobs.alphabetical.to_a
        @shift_jobs = @shift.shift_jobs
        format.js
        format.html { redirect_to shift_path(@shift_job.shift), notice: 'Job was successfully added.' }
        format.json { render action: 'show', status: :created, location: @store }
      else
        format.html { render action: 'new' }
        format.json { render json: @shift.errors, status: :unprocessable_entity }
      end
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
    redirect_to shift_path(@shift_job.shift), notice: "Successfully removed #{@shift_job.job.name} from #{@shift_job.shift.employee.proper_name}'s shift."
  end

  private
  def set_shift_job
    @shift_job = ShiftJob.find(params[:id])
  end

  def shift_job_params
    params.require(:shift_job).permit(:job_id, :shift_id)
  end

end