class API::RunnersController < ApplicationController
  before_action :set_race, only: [:index, :show, :datatable]
  before_action :set_runner, only: [:show]

  # GET /runners
  # GET /runners.json
  def index
    @runners = Race.find(params[:race_id]).runners
  end
  
  # GET /runners/datatable
  # GET /runners/datatable.json
  def datatable
  	
    per_page = params[:length].to_i > 0 ? params[:length].to_i : 10
    page = params[:start].to_i/per_page + 1
    order_column = %w[place name sex group time pace location][params[:order]['0'][:column].to_i]
    order_direction = params[:order]['0'][:dir] || "ASC"
    order = order_column + " " + order_direction
  
    query = {}
    query.merge!({ :name_cont => params[:search][:value] }) if !params[:search][:value].blank?
    @q = @race.runners.search(query)
    runners = @q.result.order(order)
    runners_paged = runners.page(page).per_page(per_page)
        
    datatable = {
      draw: params[:draw].to_i,
      recordsTotal: @race.runners.length,
      recordsFiltered: runners.length,
      data: runners_paged.map{ |r|
        {
          place: r.place,
          name: r.name,
          sex: r.sex,
          group: r.age_group,
          time: r.net_time,
          pace: r.net_pace,
          location: [ r.city, r.state, r.country ].reject(&:blank?).join(', '),
          link: race_runner_path(@race,r)
        }
      }
    }
    
    respond_to do |format|
      format.json { render json: datatable }
    end

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
      params.require(:runner).permit(:name, :place, :sex, :place_in_sex, :place_in_age_group, :age_group, :gun_time, :gun_pace, :net_time, :net_pace, :country, :state, :city)
    end
end
