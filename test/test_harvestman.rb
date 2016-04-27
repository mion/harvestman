require 'minitest/autorun'
require 'harvestman'

class TestHarvestman < MiniTest::Test
	def test_namespace
		assert Harvestman.is_a?(Module)
	end

	def test_single_page
		Harvestman.crawl "test/example1.html" do
			assert_equal "Foobar", css("title").inner_text
		end
	end

	def test_multiple_pages
		results = []

		Harvestman.crawl "test/example*.html", (1..3), :plain do
			r = {
				:title => css("head title").inner_text,
				:header => css("header div.title h1").inner_text,
				:footer => css("footer span a").inner_text,
				:list => []
			}

			css "div.main ul" do
				r[:list] << css("li").inner_text
			end

			results << r
		end

		results.each_with_index do |r, i|
			assert_equal(r[:title], "ex#{i+1}")
			assert_equal(r[:header], "#{r[:title]}_header_h1")
			assert_equal(r[:footer], "#{r[:title]}_footer_span_a")
			#assert_equal(r[:list].count, 3)
		end
	end
end
