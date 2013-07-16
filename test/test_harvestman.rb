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

			css "div.main ul" do
				r[:list] << css("li")
			end

			results << r
		end

		results.each_with_index do |r, i|
			assert_equal(r[:title], "ex#{i+1}")
			assert_equal(r[:header], "#{r[:title]}_header_h1")			
			assert_equal(r[:footer], "#{r[:title]}_footer_span_a")
			assert_equal(r[:list].count, 3)
		end
	end
end
