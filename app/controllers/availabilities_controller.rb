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
