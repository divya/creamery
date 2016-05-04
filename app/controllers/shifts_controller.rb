class ShiftsController < ApplicationController
  before_action :set_shift, only: [:show, :edit, :update, :destroy, :start_shift, :end_shift]
  authorize_resource
  
  
  def index
    @completed_shifts = Shift.completed.chronological.paginate(page: params[:completed_shifts]).per_page(10)
    @incomplete_shifts = Shift.incomplete.chronological.paginate(page: params[:incomplete_shifts]).per_page(10)  

  end

  def show
    @jobs = @shift.jobs.alphabetical
    @shift_jobs = @shift.shift_jobs
  end

  def new
    @shift = Shift.new
    if logged_in? and !current_user.role? :admin
      @store =  Assignment.current.for_employee(current_user.employee_id).first.store
    end

  end

  def edit
    @store =  Assignment.current.for_employee(current_user.employee_id).first.store
  end

  def create
    @shift = Shift.new(shift_params)

    respond_to do |format|
      if @shift.save
        @assignment = @shift.assignment
        @store =  Assignment.current.for_employee(current_user.employee_id).first.store if not current_user.employee.current_assignment.nil?
        @today_shifts = Shift.for_store(@store).for_next_days(0).chronological.paginate(page: params[:today_shifts]).per_page(5)
        @upcoming_shifts = @assignment.shifts.upcoming.chronological.paginate(page: params[:upcoming_shifts]).per_page(5)
        if logged_in? and !current_user.role? :admin
          @new_shifts = Shift.upcoming.for_store(current_user.employee.current_assignment.store).reverse_order
        else
          @new_shifts = Shift.upcoming.reverse_order
        end
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

    redirect_to :back, notice: "Successfully removed shift from the AMC system."

  end
  
  def incomplete_shifts
    @incomplete_shifts = Shift.incomplete.chronological.paginate(page: params[:incomplete_shifts]).per_page(10)  
  end

  def start_shift
    @shift.start_now
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