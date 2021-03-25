class GroupsController < ApplicationController
  before_action :set_group, only: %i[ show edit update destroy ]

  def index
    @groups = Group.all
    @group = Group.new
  end

  def new
    @group = Group.new
  end

  def add_member
    @groups = Group.all
    @member = current_user.groups.find(params[:group_id]).memberships.new
    @group_id = params[:group_id]
    @group = Group.new
    @members = Group.find(@group_id).members
  end

  def create_member
    @member_id = User.where(email: member_params[:member_email])[0].id
    @member = current_user.groups.find(params[:group_id]).memberships.new(member_id: @member_id)
    @member.save
    redirect_to group_add_member_path
  end

  def destroy_member
    Group.find(params[:group_id]).memberships.where(member_id: params[:member_id])[0].destroy
    redirect_to group_add_member_path
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

  def destroy
    @group.destroy
    redirect_to groups_path
  end

  private
    def set_group
        @group = Group.find(params[:id])
    end

  private
  def group_params
    params.require(:group).permit(:name, :owner_id)
  end

  private
  def member_params
    params.require(:membership).permit(:member_email)
  end
end