ActiveAdmin.register Race do


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :name, :date
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end

	action_item :only => :show do
    link_to 'Import Runners', admin_race_path + '/import_runners'
  end

  member_action :import_runners, method: [:get, :post] do
  	if request.post?
			race = Race.find(params[:id])
			race.import_runners_from_file(params[:import_runners][:file].tempfile.path)
		
			flash[:notice] = "Runners are importing!"
			redirect_to :action => :index
  	end
  end
  
end
