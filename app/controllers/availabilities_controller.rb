class AvailabilitiesController < ApplicationController
  before_action :set_availability, only: %i[ show edit update destroy ]

  # GET /availabilities or /availabilities.json
  def index
    @user = User.find(params[:user_id])
    @availabilities = @user.availabilities
    
  end

  # GET /availabilities/1 or /availabilities/1.json
  def show
    @availability = Availability.find(params[:id])
    @user = @availability.user
  end

  # GET /availabilities/new
  def new
    @user = User.find(params[:user_id])
    @availability = Availability.new
  end
  

  # GET /availabilities/1/edit
  def edit
    @user = User.find(params[:user_id])
    @availability = @user.availabilities.find(params[:id])
  end
  

  # POST /availabilities or /availabilities.json
  def create
    @user = User.find(params[:user_id])
    @availability = @user.availabilities.create(availability_params)
    
  
    respond_to do |format|
      if @availability.save
        format.html { redirect_to user_availability_path(@user, @availability), notice: "Availability was successfully created." }
        format.json { render :show, status: :created, location: @availability }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @availability.errors, status: :unprocessable_entity }
      end
    end
  end
  
  
  # PATCH/PUT /availabilities/1 or /availabilities/1.json
  def update
    @user = User.find(params[:user_id])
    @availability = Availability.find(params[:id])
    @availability.update(availability_params)
  end
  
  
  

  # DELETE /availabilities/1 or /availabilities/1.json
  def destroy
    @availability.destroy

    respond_to do |format|
      format.html { redirect_to users_path, notice: "Availability was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def compare
    user_names = params[:user_names]
    users = User.where(name: user_names)
    
    if users.count < 2
      flash[:error] = "Please select at least two users"
      redirect_to new_user_availability_path(user_id: params[:user_id])
    else
      user_ids = users.pluck(:id)
      @user_availability_pairs = find_common_availability(user_ids)
      render 'compare'
    end
  end
  
  
  

  def find_common_availability(user_ids)
    users = User.find(user_ids)
    user_pairs = users.combination(2).to_a
  
    common_availability = []
  
    user_pairs.each do |user_pair|
      availabilities1 = user_pair[0].availabilities.pluck(:start_time, :end_time)
      availabilities2 = user_pair[1].availabilities.pluck(:start_time, :end_time)
  
      common_slots = calculate_common_slots(availabilities1, availabilities2)
  
      common_availability << [user_pair, common_slots]
    end
  
    common_availability
  end
  def calculate_common_slots(availabilities1, availabilities2)
    common_slots = []
  
    availabilities1.each do |start_time1, end_time1|
      availabilities2.each do |start_time2, end_time2|
        latest_start_time = [start_time1, start_time2].max
        earliest_end_time = [end_time1, end_time2].min
  
        if latest_start_time < earliest_end_time
          common_slots << [latest_start_time, earliest_end_time]
        end
      end
    end
  
    common_slots
  end
  
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_availability
      @availability = Availability.find(params[:id])
      @user = @availability.user
    end

    # Only allow a list of trusted parameters through.
    def availability_params
      params.require(:availability).permit(:title, :start_time, :end_time, :user_id)
    end
end
