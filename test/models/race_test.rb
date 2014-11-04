# encoding: UTF-8

require 'test_helper'

class RaceTest < ActiveSupport::TestCase

  setup do
    @race = races(:one)
  end

  test "should import runners from text file" do
		text = <<-EOS
PLACE NAME                    SEX     &   AGEGROUP        TIME   PACE     TIME   PACE   RESIDENCE         
------------------------------------------------------------------------------------------------------------ 
    1 Geoffrey Kenisi Bundi  M#   1     1/934  M25-29     44:18  4:46     44:18  4:46   Kenya                
    2 Julius Keter           M#   2     2/934  M25-29     44:33  4:47     44:32  4:47   Kenya                
    3 Belete Assefa          M#   3     1/638  M20-24     44:44  4:48     44:43  4:48   Ethiopia             
    4 Allan Kiprono          M#   4     2/638  M20-24     44:52  4:49     44:51  4:49   Kenya                
    5 Samson Gebre. Gezahai  M#   5     3/638  M20-24     45:22  4:52     45:20  4:52   Eritrea              
  256 René Roux              M# 232     2/544  M50-54   1:00:29  6:30   1:00:20  6:29   Montréal          QC 
 5312 Noah Hammond           M#3584   504/863  M30-34   1:36:50 10:24   1:32:26  9:55   Westport          CT 
 5313 Zachary Wasielewski    M#3585   505/863  M30-34   1:36:51 10:24   1:34:50 10:11   Utica             NY 
 5314 Andra L. Kowalczyk     F#1729   324/1022 F25-29   1:36:51 10:24   1:26:06  9:15   Columbia          MD 
EOS

		file = Tempfile.new('new_runners.txt')
		file.write(text)
		file.rewind

		assert_difference "Runner.count", 9 do
			@race.import_runners_from_file( Rack::Test::UploadedFile.new(file, 'text/plain') )
		end

		updated_runner = @race.runners.find_by_place(1)
		assert_equal "Geoffrey Kenisi Bundi", updated_runner.name
		
		new_runner = @race.runners.find_by_place(5)
		assert_equal "Samson Gebre. Gezahai", new_runner.name

		global_runner = @race.runners.find_by_place(3)
		assert_equal "Ethiopia", global_runner.country
		assert_equal nil, global_runner.state
		assert_equal nil, global_runner.city
		
		local_runner = @race.runners.find_by_place(5313)
		assert_equal "United States", local_runner.country
		assert_equal "NY", local_runner.state
		assert_equal "Utica", local_runner.city

		# test multibyte UTF-8 characters
		foreign_runner = @race.runners.find_by_place(256)
		assert_equal "René Roux", foreign_runner.name
		assert_equal "Montréal", foreign_runner.city
		assert_equal "QC", foreign_runner.state
		
  end

end
