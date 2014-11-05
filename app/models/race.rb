class Race < ActiveRecord::Base
	
	has_many :runners
	
  def import_runners_from_file(file)
  	runners = parse_runners_from_file(file)
    runners[:body].each do |runner_data|
    	self.import_runner(runner_data)
    end
  end
  
  def import_runner(r)
		if r[:place] > 0
			
			r = normalize_runner_data(r)
			
			runner = Runner.find_or_initialize_by({:race_id => self.id, :place => r[:place]})
			runner.update(
				place: r[:place],
				name: r[:name],
				sex: r[:sex],
				place_in_sex: r[:place_in_sex],
				place_in_age_group: r[:place_in_age_group],
				total_in_age_group: r[:total_in_age_group],
				age_group: r[:age_group],
				gun_time: r[:gun_time],
				gun_pace: r[:gun_pace],
				net_time: r[:net_time],
				net_pace: r[:net_pace],
				country: r[:country],
				state: r[:state],
				city: r[:city]
			)
			
		end  	
  end
  
	def parse_runners_from_file(file)
		
    Slither.define :runners, :by_bytes => false, :validate_length => false, force_character_offset: true do |d|
      d.header do |header|
    		header.trap { |line|
        	!(line[0,6] =~ /\s*[0-9]+\s/)
    		}
    	end
      d.body do |body|
        body.trap { |line|
        	!!(line[0,6] =~ /\s*[0-9]+\s/)
        }
        body.column :place, 5, :type => :integer, :align => :right
        body.spacer 1
        body.column :name, 22
        body.spacer 1
        body.column :sex, 1
        body.spacer 1
        body.column :place_in_sex, 4, :type => :integer
        body.spacer 3
        body.column :place_in_age_group, 3, :type => :integer
        body.spacer 1
        body.column :total_in_age_group, 3, :type => :integer
        body.spacer 2
        body.column :age_group, 6
        body.spacer 3
        body.column :gun_time, 7, :align => :right
        body.spacer 1
        body.column :gun_pace, 5, :align => :right
        body.spacer 3
        body.column :net_time, 7, :align => :right
        body.spacer 1
        body.column :net_pace, 5
        body.spacer 3
        body.column :city_or_country, 17
        body.spacer 1
        body.column :state, 2
        body.spacer 1
      end
    end
    runners = Slither.parse(file,:runners)
	end
  
  def normalize_runner_data(runner_data)
		location = normalize_location(runner_data[:city_or_country],runner_data[:state])
		runner_data[:name] = runner_data[:name].force_encoding('UTF-8')
		runner_data[:country] = location[:country]
		runner_data[:state] = location[:state]
		runner_data[:city] = location[:city]
		runner_data
  end
  
  def normalize_location(city_or_country,state)
  	location = {}
		if state.empty?
			location[:country] = city_or_country.force_encoding('UTF-8') # Country.named(vals[:city_or_country]).code
			location[:state] = nil
			location[:city] = nil
		else
			location[:country] = 'United States' # Country.named("United States").code
			location[:state] = state.force_encoding('UTF-8')
			location[:city] = city_or_country.force_encoding('UTF-8')
		end
		location
  end

end
