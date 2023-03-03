class AvailabilitiesController < ApplicationController

    rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found
    before_action :set_availability, only: %i[show edit update destroy]


    def index
      @user = User.find(params[:user_id])
      @availabilities = @user.availabilities
    end

    def show
      @user = @availability.user
    end

    def new
      @user = User.find(params[:user_id])
      @availability = Availability.new
    end

    def edit
      @user = User.find(params[:user_id])
    end

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


    def update
      @user = User.find(params[:user_id])
      if @availability.update(availability_params)
        redirect_to user_availability_path(@user, @availability), notice: 'Availability was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @user = User.find(params[:user_id])
      @availability.destroy
      respond_to do |format|
        format.html { redirect_to user_availabilities_path(@user), notice: "Availability was successfully destroyed." }
        format.json { head :no_content }
      end
    end


    def compare
      user_names = params[:user_names]
      users = User.where(name: user_names)
      user_ids = users.pluck(:id)
      @user_availability_pairs = find_common_availability(user_ids)
      render 'compare'
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

    def set_availability
      @availability = Availability.find(params[:id])
      @user = @availability.user


    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "Availability not found"
      redirect_to user_availabilities_path(params[:user_id])
    end

    def availability_params
      params.require(:availability).permit(:title, :start_time, :end_time, :user_id)
    end

    def catch_not_found
      flash[:alert] = "Availability not found"
      if params[:user_id]
        redirect_to user_availabilities_path(params[:user_id])
      else
        redirect_to users_path
      end
    end

  end

