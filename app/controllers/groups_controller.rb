class GroupsController < ApplicationController
  before_action :set_group, only: %i[ show edit update destroy ]

  def index
    @groups = Group.all
    @group = Group.new
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    
    if @group.save
      redirect_to groups_path
    else
      @groups = Group.all
      render :index
    end
  end

  private
  def group_params
    params.require(:group).permit(:name, :owner_id)
  end
  
end