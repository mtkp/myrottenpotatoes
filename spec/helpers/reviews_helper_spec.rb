require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the ReviewsHelper. For example:
#
# describe ReviewsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
describe ReviewsHelper do
  describe "review_class" do
    it "returns no-rating class if the average is zero" do
      css_class = helper.review_class(0.0)
      css_class.should =~ /\Ano-rating\z/
    end
    it "returns low-rating class if the average is between 1 and 2" do
      [1.0, 1.9].each do |i|
        css_class = helper.review_class(i)
        css_class.should =~ /\Alow-rating\z/
      end
    end
    it "returns mid-low-rating class if the average is between 2 and 3" do
      [2.0, 2.9].each do |i|
        css_class = helper.review_class(i)
        css_class.should =~ /\Amid-low-rating\z/
      end
    end
    it "returns mid-high-rating class if the average is between 3 and 4" do
      [3.0, 3.9].each do |i|
        css_class = helper.review_class(i)
        css_class.should =~ /\Amid-high-rating\z/
      end
    end
    it "returns high-rating class if the average is between 4 and 5" do
      [4.0, 4.9, 5.0].each do |i|
        css_class = helper.review_class(i)
        css_class.should =~ /\Ahigh-rating\z/
      end
    end
    it "returns an empty string otherwise" do
      css_class = helper.review_class(5.1)
      css_class.should be_empty
    end
  end
end
