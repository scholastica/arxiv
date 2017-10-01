module Arxiv
  class Author
    include HappyMapper
    element :name, StringScrubber, parser: :scrub
    has_many :affiliations, StringScrubber, parser: :scrub, tag: 'affiliation'

    # Unfortunately, the ArXiv API does not provide separate attributes for
    # `author.first_name` and `author.last_name`; it only provides a single
    # `author.name` attribute.
    #
    # Yet most standards within academic publishing (e.g. JATS XML) prefer to
    # differentiate first name and last name of authors. To support that
    # expectation, we've split the name value (leveraging a third-party gem).
    # Ideally, ArXiv would provide this data directly. But until then, this
    # solution should be suitable.
    #
    def first_name
      FullNameSplitter.split(name).first
    end

    # See code comment for `first_name`.
    #
    def last_name
      FullNameSplitter.split(name).last
    end
  end
end
