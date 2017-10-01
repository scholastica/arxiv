module Arxiv
  class Author
    include HappyMapper
    element :name, StringScrubber, parser: :scrub
    has_many :affiliations, StringScrubber, parser: :scrub, tag: 'affiliation'

    def first_name
      FullNameSplitter.split(name).first
    end

    def last_name
      FullNameSplitter.split(name).last
    end
  end
end
