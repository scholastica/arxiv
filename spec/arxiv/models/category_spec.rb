require 'spec_helper'

module Arxiv
  describe Category do
    let!(:category) { Arxiv.get('1202.0819').primary_category }
    let!(:legacy_category) { Arxiv.get('math.DG/0510097v1').categories.last }

    describe "abbreviation" do
      it "should fetch the category's abbreviation" do
        expect(category.abbreviation).to eq "astro-ph.IM"
      end
    end

    describe "description" do
      it "should fetch the category's description" do
        expect(category.description).to eq "Physics - Instrumentation and Methods for Astrophysics"
      end
    end

    describe "long_description" do
      it "should fetch the category's abbreviation and description"do
        expect(category.long_description).to eq "astro-ph.IM (Physics - Instrumentation and Methods for Astrophysics)"
      end
      it "should just return the abbreviation when a description cannot be found (e.g. MSC classes)"do
        expect(legacy_category.long_description).to eq "58D15 (Primary); 58B10 (Secondary)"
      end
    end

  end
end
