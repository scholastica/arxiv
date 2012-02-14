require 'arxiv/version'
require 'open-uri'
require 'nokogiri'
require 'happymapper'

module Arxiv

  def self.get(id)
    url = ::URI.parse("http://export.arxiv.org/api/query?id_list=#{id}")
    response = ::Nokogiri::XML(open(url)).remove_namespaces!
    manuscript = Arxiv::Manuscript.parse(response.to_s, single: id)
  end

  class StringScrubber
    def self.scrub(string)
      string.gsub("\n", ' ').strip.squeeze(" ")
    end
  end

  class Author
    include HappyMapper
    element :name, StringScrubber, parser: :scrub
    has_many :affiliations, StringScrubber, parser: :scrub, tag: 'affiliation'
  end

  class Link
    include HappyMapper
    attribute :url, String, tag: 'href'
    attribute :content_type, String, tag: 'type'
  end

  class Category
    include HappyMapper

    def self.types
      url = ::URI.parse("http://arxiv-api.googlegroups.com/attach/5e540c5aa16cd1a1/servicedocument.xml?gda=GkSq-0UAAACv8MuSQ9shr-Fm8egpLVNUyoJFgZHB152DBrQX4ANeXa_N1TJg9KB-8oF-EwbRpI6O3f1cykW9hbJ1ju6H3kglGu1iLHeqhw4ZZRj3RjJ_-A&view=1&part=2")
      xml = ::Nokogiri::XML(open(url)).remove_namespaces!
      category_mapping = {}
      categories = xml.xpath("/service/workspace/collection/categories/category")
      categories.each do |category|
        abbreviation = category.attributes["term"].value.match(/[^\/]+$/)[0]
        description = category.attributes["label"].value
        category_mapping.merge!(abbreviation => description)
      end
      category_mapping
    end

    Types = Category.types

    attribute :abbreviation, String, tag: 'term'

    def description
      Types[abbreviation]
    end

    def long_description
      "#{abbreviation} (#{description})"
    end

  end

  class Manuscript
    include HappyMapper

    tag 'entry'
    element :arxiv_url, String, tag: 'id'
    element :created_at, DateTime, tag: 'published'
    element :updated_at, DateTime, tag: 'published'
    element :title, StringScrubber, parser: :scrub
    element :summary, StringScrubber, parser: :scrub
    element :comment, StringScrubber, parser: :scrub
    has_one :primary_category, Category
    has_many :categories, Category
    has_many :authors, Author
    has_many :links, Link

    alias :abstract :summary

    def revision?
      created_at != updated_at
    end

    def arxiv_id
      arxiv_url.match(/([^\/]+)v\d+$/)[1]
    end

    def arxiv_versioned_id
      arxiv_url.match(/([^\/]+)$/)[1]
    end

    def version
      arxiv_url.match(/v(\d+)$/)[1].to_i
    end

    def content_types
      links.map(&:content_type)
    end

    def available_in_pdf?
      content_types.any? { |type| type == "application/pdf" }
    end

    def pdf_url
      links.find { |l| l.content_type == "application/pdf" }.url if available_in_pdf?
    end

  end

end
