class PlansController < ApplicationController
  before_action :set_plan, only: [:show, :edit, :update, :destroy]

  # GET /plans
  # GET /plans.json
  def index
    @plans = Plan.all
  end

  # GET /plans/1
  # GET /plans/1.json
  def show
  end

  # GET /plans/new
  def search
    @group = Group.new
  end

  def new
    @group = Group.new
    trip =  if params["group"]["trip_id"].blank?
              current_user.trips.create(name_place: params['group']['query'])
            else
              Trip.find(params["group"]["trip_id"])
            end

    @group = trip.groups.new(group_params)

    set_groups
  end

  # GET /plans/1/edit
  def edit
  end

  # POST /plans
  # POST /plans.json
  def create
    @group = current_user.owned_groups.new(group_params)
    set_groups

    respond_to do |format|
      if @group.save
        @group.users << current_user
        flash[:notice] =  'Grup berhasil dibuat.'
        format.html { redirect_to group_trip_path(@group.trip, @group) }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plans/1
  # PATCH/PUT /plans/1.json
  def update
    respond_to do |format|
      if @plan.update(plan_params)
        format.html { redirect_to @plan, notice: 'Plan was successfully updated.' }
        format.json { render :show, status: :ok, location: @plan }
      else
        format.html { render :edit }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plans/1
  # DELETE /plans/1.json
  def destroy
    @plan.destroy
    respond_to do |format|
      format.html { redirect_to plans_url, notice: 'Plan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plan
      @group = Group.find(params[:id])
    end

    def set_groups
      @groups = Group.where(
        "trip_id = :trip_id AND start_to_trip < :end_to_trip AND end_to_trip > :start_to_trip",
        {
          start_to_trip: params[:group][:start_to_trip],
          end_to_trip: params[:group][:end_to_trip],
          trip_id: @group.trip.id
        }
      )
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:trip_id, :start_to_trip, :end_to_trip, :lat, :lng, :group_name, :image, :photo, :category_id, :location)
    end
end
