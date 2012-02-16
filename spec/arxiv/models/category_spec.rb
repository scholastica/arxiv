require 'spec_helper'

module Arxiv
  describe Category do
    before(:all) do
      @category = Arxiv.get('1202.0819').primary_category
      @legacy_category = Arxiv.get('math.DG/0510097v1').categories.last
    end

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
      it "should fetch the category's abbreviation and description"do
        @category.long_description.should == "astro-ph.IM (Physics - Instrumentation and Methods for Astrophysics)"
      end
      it "should just return the abbreviation when a description cannot be found (e.g. MSC classes)"do
        @legacy_category.long_description.should == "58D15 (Primary); 58B10 (Secondary)"
      end
    end

  end
end