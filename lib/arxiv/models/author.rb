module Arxiv
  class Author
    include HappyMapper
    element :name, StringScrubber, parser: :scrub
    has_many :affiliations, StringScrubber, parser: :scrub, tag: 'affiliation'
  end
end
