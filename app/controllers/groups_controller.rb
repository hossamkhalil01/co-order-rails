class GroupsController < ApplicationController
  before_action :set_group, only: %i[ show edit update destroy ]

  def index
    @groups = Group.all
    @group = Group.new
  end

  def new
    @group = Group.new
  end

  def search
    if params[:member].present?
      @group = current_user.groups.find(params[:group_id])
      @members = User.search(params[:member])
      @members = current_user.except_current_user(@members)
      if @members
        respond_to do |format|
          format.js { render partial: 'groups/member_result' }
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Couldn't find user"
          format.js { render partial: 'groups/member_result' }
        end
      end    
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a friend name or email to search"
        format.js { render partial: 'users/member_result' }
      end
    end
  end

  def add_member
    @groups = Group.all
    @member = current_user.groups.find(params[:group_id]).memberships.new
    @group_id = params[:group_id]
    @current_group = Group.find(@group_id)
    @group = Group.new
    @members = Group.find(@group_id).members
  end

  def create_member
    @member = User.find(params[:member])
    @member = current_user.groups.find(params[:group_id]).memberships.new(member_id: @member.id)
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