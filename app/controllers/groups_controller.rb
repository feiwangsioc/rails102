class GroupsController < ApplicationController
  before_action :authenticate_user! , only: [:new, :create, :edit, :update, :destroy]
  def index
    @groups = Group.all
  end
  
  def show
    @group = Group.find(params[:id])
  end 
  
  def edit 
    find_group_and_check_permission
  end 
  
  def new 
    @group = Group.new
  end
  
  def create
    @group = Group.new(group_params)
    @group.user = current_user
    if @group.save
    
    redirect_to groups_path
    else 
      render :new
    end 
  end 
  
  def update
   find_group_and_check_permission
    
    if @group.update(group_params)
    
    redirect_to groups_path, notice: "update sucess"
    else 
    render :new
    end 
  end 
  
  def destroy
   find_group_and_check_permission
    
    @group.destroy
    flash[:altert] = "Group deleted"
    redirect_to groups_path
  end 
  
  private 
  
  def find_group_and_check_permission
    @group = Group.find(params[:id])

    if current_user != @group.user
      redirect_to root_path, alert: "You have no permission."
    end
  end
  
  
  def group_params
    params.require(:group).permit(:title, :description)
  end 
end