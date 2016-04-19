class StoreFlavorsController < ApplicationController
  before_action :set_store_flavor, only: [:show, :edit, :update, :destroy]
  
  def index
     
  end

  def show
    #@current_assignments = @store.assignments.current.by_employee.paginate(page: params[:page]).per_page(8)
  end

  def new
    @store_flavor = StoreFlavor.new
  end

  def edit
  end

  def create
    @store_flavor = StoreFlavor.new(store_flavor_params)
    
    if @store_flavor.save
      redirect_to store_path(@store_flavor.store), notice: "Successfully added #{@store_flavor.flavor_id.name} to #{@store_flavor.store_id.name}."
    else
      render action: 'new'
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
    redirect_to stores_path, notice: "Successfully removed #{@store_flavor.flavor_id.name} from #{@store_flavor.store_id.name}."
  end

  private
  def set_store_flavor
    @store_flavor = StoreFlavor.find(params[:id])
  end

  def store_flavor_params
    params.require(:store_flavor).permit(:store_id, :flavor_id)
  end

end