class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
  user ||= User.new # guest user (not logged in)

  if user.role? :admin
    can :manage, :all

  elsif user.role? :manager
      # can see a list of all users
      can :read, Store
      can :read, Shift
      can :read, Job
      can :read, Flavor
      can :read, ShiftJob
      can :read, StoreFlavor


      can :update, Shift do |this_shift|
        managed_store = user.employee.current_assignment.store 
        managed_shifts = Shift.for_store(managed_store).map{|s| s.id}
        managed_shifts.include? this_shift.id 
      end


      can :create, Shift do |this_shift|
        managed_store = user.employee.current_assignment.store 
        managed_employees = Assignment.current.for_store(managed_store).map{|a| a.employee.id} 
        managed_employees.include? this_shift.employee.id && managed_store == this_shift.store.id
      end

      can :destroy, Shift do |this_shift|
        managed_store = user.employee.current_assignment.store 
        managed_shifts = Shift.for_store(managed_store).map{|s| s.id}
        managed_shifts.include? this_shift.id 
      end

      can :create, StoreFlavor do |this_sf|
        managed_store = user.employee.current_assignment.store 
        store_flavors = managed_store.store_flavors.map{|a| a.id} 
        store_flavors.include? this_sf.id 
      end

      can :destroy, StoreFlavor do |this_sf|
        managed_store = user.employee.current_assignment.store
        store_flavors = managed_store.store_flavors.map{|a| a.id} 
        store_flavors.include? this_sf.id 
      end

      can :create, ShiftJob do |this_sj|
        managed_store = user.employee.current_assignment.store 
        managed_shifts = Shift.for_store(managed_store).map{|s| s.id}
        managed_shifts.include? this_sj.shift.id
      end

      can :destroy, ShiftJob do |this_sj|
        managed_store = user.employee.current_assignment.store
        managed_shifts = Shift.for_store(managed_store).map{|s| s.id}
        managed_shifts.include? this_sj.shift.id
      end

      can :update, User do |u|  
        u.id == user.id
      end

      can :update, Employee do |e|  
        e.id == user.employee.id
      end

      can :read, Employee do |this_employee|
        managed_store = user.employee.current_assignment.store 
        managed_employees = Assignment.current.for_store(managed_store).map{|a| a.employee.id} 
        managed_employees.include? this_employee.id 
      end

      can :read, Assignment do |this_assignment|
        managed_store = user.employee.current_assignment.store 
        managed_assignments = Assignment.current.for_store(managed_store).map{|a| a.id} 
        managed_assignments.include? this_assignment.id 
      end


   elsif user.role? :employee
      can :update, User do |u|  
        u.id == user.id
      end

      can :update, Employee do |e|  
        e.id == user.employee.id
      end

      can :read, Employee do |e|  
        e.id == user.employee.id
      end
      
      can :read, Shift do |s|  
        my_shifts = Shift.for_employee(user).map{|s| s.id}
        my_shifts.include? s.id 
      end

      can :start_shift, Shift do |s|  
        my_shifts = Shift.for_employee(user).map{|s| s.id}
        my_shifts.include? s.id 
      end

      can :end_shift, Shift do |s|  
        my_shifts = Shift.for_employee(user).map{|s| s.id}
        my_shifts.include? s.id 
      end

      can :read, Store
      can :read, Job
      can :read, Flavor


  else
      can :read, Store
  end

    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities

  end
end
