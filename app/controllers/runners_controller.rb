class RunnersController < ApplicationController
  before_action :set_race, only: [:index, :show]
  before_action :set_runner, only: [:show]

  # GET /runners
  # GET /runners.json
  def index
    query = {}
    query.merge!(params[:q]) if !params[:q].blank?
    @q = @race.runners.search(query)
    @runners = @q.result.order('place ASC').page(params[:page]).per_page(10)
  end

  # GET /runners/1
  # GET /runners/1.json
  def show
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
