class HomeController < ApplicationController

  def home
  end

  def about
  end

  def privacy
  end

  def contact
  end

  def dashboard
  	@store =  Assignment.for_employee(current_user.employee_id).first.store
  	@shifts = Shift.for_store(@store).for_next_days(0).chronological #.paginate(page: params[:page]).per_page(5)

    # --- WEIRD SHIT HAPPENS TO SHIFTS AJAX IF I PUT THIS VARIABLE HERE INSTEAD OF IN THE VIEWS ----------------------------
    #@storeassignments = Assignment.current.for_store(@store).paginate(page: params[:page]).per_page(15)
  end

  def manage_shifts
    @store =  Assignment.for_employee(current_user.employee_id).first.store
    @shifts = Shift.for_store(@store).for_next_days(0).chronological
  end

end