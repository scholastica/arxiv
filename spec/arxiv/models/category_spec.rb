require 'spec_helper'

module Arxiv
  describe Category do
    before(:all) { @category = Arxiv.get('1202.0819').primary_category }

    describe "abbreviation" do
      it "should fetch the category's abbreviation" do
        @category.abbreviation.should == "astro-ph.IM"
      end
    end

    describe "description" do
      it "should fetch the category's description" do
        @category.description.should == "Physics - Instrumentation and Methods for Astrophysics"
      end
    end

    describe "long_description" do
      it "should fetch the category's #long_description" do
        @category.long_description.should == "astro-ph.IM (Physics - Instrumentation and Methods for Astrophysics)"
      end
    end

  end
end