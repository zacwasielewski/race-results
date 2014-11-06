class RunnersController < ApplicationController
  before_action :set_race, only: [:index, :show]
  before_action :set_runner, only: [:show]

  # GET /runners
  # GET /runners.json
  def index
    @runners = Race.find(params[:race_id]).runners
  end

  # GET /runners/1
  # GET /runners/1.json
  def show
  end

  # GET /runners/new
  def new
  end

  # GET /runners/1/edit
  def edit
  end

  # POST /runners
  # POST /runners.json
  def create
  end

  # PATCH/PUT /runners/1
  # PATCH/PUT /runners/1.json
  def update
  end

  # DELETE /runners/1
  # DELETE /runners/1.json
  def destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_race
      @race = Race.find(params[:race_id])
    end

    def set_runner
      @runner = Runner.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def runner_params
      params.require(:runner).permit(:name, :place, :sex, :place_in_sex, :place_in_age_group, :age_group, :gun_time, :gun_pace, :net_time, :net_pace, :country, :state)
    end
end
