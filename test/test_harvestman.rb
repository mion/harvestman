require 'helper'

class TestHarvestman < Test::Unit::TestCase
	def test_namespace
		assert Harvestman.is_a?(Module)
	end

	def test_scraping
		results = []

		Harvestman.crawl "test/example*.html", (1..3), :plain do
			r = {
				:title => css("head title"),
				:header => css("header div.title h1"),
				:footer => css("footer span a"),
				:list => []
			}

			css("div.main ul") do
				r[:list] << css("li")
			end

			results << r
		end

		results.each_with_index do |result, i|
			assert_equal(result[:title], "ex#{i+1}")
			assert_equal(result[:header], "#{result[:title]}_header_h1")
		end
	end
end
