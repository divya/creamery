class HomeController < ApplicationController

  def home
    @active_stores = Store.active
  end

  def about
  end

  def privacy
  end

  def contact
  end

  def dashboard
  	@store =  Assignment.current.for_employee(current_user.employee_id).first.store
  	#@shifts = Shift.for_store(@store).for_next_days(0).chronological #.paginate(page: params[:page]).per_page(5)
    @store_flavors = @store.store_flavors
    @today_shifts = Shift.for_store(@store).for_next_days(0).chronological.paginate(page: params[:page]).per_page(5)

    # --- WEIRD SHIT HAPPENS TO SHIFTS AJAX IF I PUT THIS VARIABLE HERE INSTEAD OF IN THE VIEWS ----------------------------
    #@assignments = Assignment.current.for_store(@store).paginate(page: params[:page]).per_page(15)
  end

  def manage_shifts
    @store =  Assignment.current.for_employee(current_user.employee_id).first.store
    @today_shifts = Shift.for_store(@store).for_next_days(0).chronological.paginate(page: params[:page]).per_page(5)
    #@shift_jobs = @shift.shift_jobs
  end

  def employee_home
    @employee = current_user.employee
    @today_shifts = Shift.for_employee(@employee).for_next_days(0) #.paginate(page: params[:page]).per_page(5)
  end

  def past_shifts
    @store =  Assignment.current.for_employee(current_user.employee_id).first.store
    #@yesterday = Shift.for_store(@store).for_past_days(1).chronological.paginate(page: params[:page]).per_page(5)
    @past_shifts_c = Shift.for_store(@store).completed.past.chronological.paginate(page: params[:page]).per_page(5)
    @past_shifts_i = Shift.for_store(@store).incomplete.past.chronological.paginate(page: params[:page]).per_page(5)
  end

  def future_shifts
    @store =  Assignment.current.for_employee(current_user.employee_id).first.store
    #@tomorrow = (Shift.for_store(@store).for_next_days(1).chronological - Shift.for_store(@store).for_next_days(0).chronological).paginate(page: params[:page]).per_page(5)
    @future_shifts = Shift.for_store(@store).after_today.chronological.paginate(page: params[:page]).per_page(5)
    #@shift_jobs = @shift.shift_jobs
  end

  def account
    @employee = current_user.employee
    @current_assgn = current_user.employee.current_assignment
    @assignments = @employee.assignments.chronological.paginate(page: params[:page]).per_page(5) 
  end

  def employee_shifts
    @employee = current_user.employee
    @today_shifts = Shift.for_employee(@employee).for_next_days(0).paginate(page: params[:page]).per_page(5) 
    @upcoming_shifts = Shift.for_employee(@employee).for_next_days_after_today(14).paginate(page: params[:page]).per_page(5)
    @past_shifts = Shift.for_employee(@employee).past.paginate(page: params[:page]).per_page(5)
    
  end


end