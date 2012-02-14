module Arxiv
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