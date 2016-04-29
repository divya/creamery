class ShiftsController < ApplicationController
  before_action :set_shift, only: [:show, :edit, :update, :destroy]
  
  def index
    @completed_shifts = Shift.completed.chronological.paginate(page: params[:page]).per_page(10)
    @incomplete_shifts = Shift.incomplete.chronological.paginate(page: params[:page]).per_page(10)  
  end

  def show
    @jobs = @shift.jobs.alphabetical #.paginate(page: params[:page]).per_page(8)
  end

  def new
    @shift = Shift.new
    @store =  Assignment.for_employee(current_user.employee_id).first.store
    #@assignment =  Assignment.find(params[:assignment_id])  

  end

  def edit
  end

  def create
    @shift = Shift.new(shift_params)


    respond_to do |format|
      if @shift.save
        #@store = @shift.assignment.store
        @store =  Assignment.for_employee(current_user.employee_id).first.store
        @shifts = Shift.for_store(@store).for_next_days(0).chronological #.paginate(page: params[:page]).per_page(5)
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
    redirect_to dashboard_path, notice: "Successfully removed shift from the AMC system."
  end

  private
  def set_shift
    @shift = Shift.find(params[:id])
  end

  def shift_params
    params.require(:shift).permit(:assignment_id, :date, :start_time, :end_time, :notes)
  end

end