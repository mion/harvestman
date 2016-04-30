require 'minitest/autorun'
require 'harvestman'

class TestHarvestman < MiniTest::Test
	def test_namespace
		assert Harvestman.is_a?(Module)
	end

	def test_single_page
		result = {}
		Harvestman.crawl "test/fixtures/index.html" do
			# grab the title
			result[:title] = css("title").inner_text

			# grab the text inside the <a> element that points to the second page
			el = css("a[href*=page2]").first
			result[:second_page_text] = el.inner_text
		end
		assert_equal result[:title], "Home Page"
		assert_equal result[:second_page_text], "Second page"
	end

	def test_multiple_pages
		results = []

		Harvestman.crawl "test/fixtures/page*.html", (1..3), :plain do
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
