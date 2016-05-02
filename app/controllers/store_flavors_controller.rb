class StoreFlavorsController < ApplicationController
  before_action :set_store_flavor, only: [:show, :edit, :update, :destroy]
  
  def index
     
  end

  def show
    #@current_assignments = @store.assignments.current.by_employee.paginate(page: params[:page]).per_page(8)
  end

  def new
    @store_flavor = StoreFlavor.new
    #----------ADD IF LOGGED IN STATEMENT ------------------------------
    if logged_in? and !current_user.role? :admin
      @store = Assignment.for_employee(current_user.employee_id).first.store
    end

    #----------ADD THIS FUNCTIONALITY TO JOBS TOO ------------------------------
    @remaining_flavors = Flavor.active #- @store.store_flavors.map{|n| n.flavor}
  end

  def edit
  end

  def create

    @store_flavor = StoreFlavor.new(store_flavor_params)

    respond_to do |format|
      if @store_flavor.save
        #@store = @shift.assignment.store
        @store = @store_flavor.store
        #@jobs = @shift.jobs.alphabetical.to_a
        @store_flavors = @store.store_flavors
        format.js
        format.html { redirect_to dashboard_path, notice: 'Job was successfully added.' }
        format.json { render action: 'show', status: :created, location: @store }
      else
        format.html { render action: 'new' }
        format.json { render json: @store_flavor.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @store_flavor.update(store_flavor_params)
      redirect_to store_path(@store), notice: "Successfully updated flavor in #{@store_flavor.store_id.name}."
    else
      render action: 'edit'
    end
  end

  def destroy
    @store_flavor.destroy
    redirect_to dashboard_path, notice: "Successfully removed #{@store_flavor.flavor.name} from #{@store_flavor.store.name}."
  end

  private
  def set_store_flavor
    @store_flavor = StoreFlavor.find(params[:id])
  end

  def store_flavor_params
    params.require(:store_flavor).permit(:store_id, :flavor_id)
  end

end