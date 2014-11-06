=begin

This model file is extracted from a basic, proof-of-concept Rails app. The app allows an
admin to import road race results from a fixed-width text file. The results are publicly
viewable in a sortable, searchable, paginated table interface.

This app is not full-featured, but rather intended to demonstrate familiarity with
a variety of Rails development concepts:

- ORM
- Routing
- Data import
- API creation
- User authentication and admin management
- Automated testing
- Version control
- Deployment

The full, live app can be viewed here:

URL:		https://cryptic-tor-3432.herokuapp.com/

Admin:	https://cryptic-tor-3432.herokuapp.com/admin
				- username: admin@example.com
				- password: password
				
Repo:		https://github.com/zacwasielewski/race-results

I appreciate your consideration!

Thanks,
Zac Wasielewski

=end

class Race < ActiveRecord::Base
	
	has_many :runners
	
  def import_runners_from_file(file)
  
		ActiveRecord::Base.transaction do
			parse_runner_data_from_file(file).each{ |runner_data|
				runner = Runner.find_or_initialize_by({ :race_id => self.id, :place => runner_data[:place] })
				runner.attributes = normalize_runner_data(runner_data)
				runner.save
			}
		end
  	
  end
  
	def parse_runner_data_from_file(file)
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
    Slither.parse(file,:runners)[:body]
	end
  
  def normalize_runner_data(runner)
		location = normalize_location(runner[:city_or_country],runner[:state])
  	normalized = {
			:place							=> runner[:place],
			:name								=> runner[:name].force_encoding('UTF-8'),
			:sex								=> runner[:sex],
			:place_in_sex				=> runner[:place_in_sex],
			:place_in_age_group => runner[:place_in_age_group],
			:total_in_age_group => runner[:total_in_age_group],
			:age_group					=> runner[:age_group],
			:gun_time						=> runner[:gun_time],
			:gun_pace						=> runner[:gun_pace],
			:net_time						=> runner[:net_time],
			:net_pace						=> runner[:net_pace],
			:country						=> location[:country],
			:state							=> location[:state],
			:city								=> location[:city]
		}
  end
  
  def normalize_location(city_or_country,state)
  	location = {}
		if state.empty?
			location[:country] = city_or_country.force_encoding('UTF-8')
			location[:state] = nil
			location[:city] = nil
		else
			location[:country] = 'United States'
			location[:state] = state.force_encoding('UTF-8')
			location[:city] = city_or_country.force_encoding('UTF-8')
		end
		location
  end

end
