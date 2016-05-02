class ShiftsController < ApplicationController
  before_action :set_shift, only: [:show, :edit, :update, :destroy]
  authorize_resource
  
  
  def index
    @completed_shifts = Shift.completed.chronological.paginate(page: params[:page]).per_page(10)
    @incomplete_shifts = Shift.incomplete.chronological.paginate(page: params[:page]).per_page(10)  
    # @store =  Assignment.for_employee(current_user.employee_id).first.store
    # @shifts = Shift.for_store(@store).for_next_days(0).chronological
  end

  def show
    @jobs = @shift.jobs.alphabetical#.paginate(page: params[:page]).per_page(8)
    @shift_jobs = @shift.shift_jobs
  end

  def new
    @shift = Shift.new
    @store =  Assignment.current.for_employee(current_user.employee_id).first.store
    #@assignment =  Assignment.find(params[:assignment_id])  

  end

  def edit
    @store =  Assignment.current.for_employee(current_user.employee_id).first.store
  end

  def create
    @shift = Shift.new(shift_params)

    #@shift.start_time = @shift.start_time.localtime if @shift.start_time
    #@shift.end_time = @shift.end_time.localtime if @shift.end_time
    respond_to do |format|
      if @shift.save
        @assignment = @shift.assignment
        @store =  Assignment.current.for_employee(current_user.employee_id).first.store
        @today_shifts = Shift.for_store(@store).for_next_days(0).chronological.paginate(page: params[:page]).per_page(5)
        @upcoming_shifts = @assignment.shifts.upcoming.chronological.paginate(page: params[:page]).per_page(5)
        @new_shifts = Shift.upcoming.for_store(current_user.employee.current_assignment.store).reverse_order
        format.js
        format.html { redirect_to @shift, notice: 'Shift was successfully created.' }
        format.json { render action: 'show', status: :created, location: @store }
      else
        format.html { render action: 'new' }
        format.json { render json: @shift.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @shift.update(shift_params)
      redirect_to shift_path(@shift), notice: "Successfully updated shift."
    else
      render action: 'edit'
    end
  end

  def destroy
    @shift.destroy
    redirect_to myshifts_path, notice: "Successfully removed shift from the AMC system."
  end



  def start_shift
    @shift.start_now
    @shift.save!
    redirect_to employee_home_path, notice: "Successfully started shift."
  end

  def end_shift
    @shift.end_now
    redirect_to employee_home_path, notice: "Successfully ended shift."
  end

  private
  def set_shift
    @shift = Shift.find(params[:id])
  end

  def shift_params
    params.require(:shift).permit(:assignment_id, :date, :start_time, :end_time, :notes)
  end

end