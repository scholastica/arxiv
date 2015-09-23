module Arxiv
  class Category
    include HappyMapper

    # ArXiv categorizes articles by rather specific subject area using a system
    # of abbreviated subject codes. For example, "astro-ph.CO" is the code for
    # "Physics - Cosmology and Extragalactic Astrophysics". As you may expect
    # there are a lot of codes.
    #
    # While terse to the laymen, scientists are apparently very familiar with
    # the abbreviated codes for their discipline. Nevertheless, all things
    # considered, it would be better to also offer a more human readable
    # description.
    #
    # ArXiv has an official mapping between abbreviation (astro-ph.CO) and
    # label (Physics - Cosmology and Extragalactic Astrophysics) but
    # unfortunately it's not available through their API. Actually, it's an
    # XML file attached to a Google Groups discussion thread at
    # http://arxiv-api.googlegroups.com/attach/5e540c5aa16cd1a1/servicedocument.xml?gda=GkSq-0UAAACv8MuSQ9shr-Fm8egpLVNUyoJFgZHB152DBrQX4ANeXa_N1TJg9KB-8oF-EwbRpI6O3f1cykW9hbJ1ju6H3kglGu1iLHeqhw4ZZRj3RjJ_-A&view=1&part=2.
    #
    # Relying directly on this attachment has been a problem in the past. As a
    # result, we decided to store a local copy in this project at
    # `lib/arxiv/data`. Not ideal but it's our best option until they update
    # their API.
    #
    PATH_TO_CATEGORY_MAPPING_DATA = File.expand_path(File.dirname(__FILE__)) + "/../data/category_abbreviation_to_label_mapping.xml"

    @@category_mapping = {}

    def self.types
      return @@category_mapping unless @@category_mapping.empty?

      file = File.read(PATH_TO_CATEGORY_MAPPING_DATA)
      xml = ::Nokogiri::XML(file).remove_namespaces!

      categories = xml.xpath("/service/workspace/collection/categories/category")
      categories.each do |category|
        abbreviation = category.attributes["term"].value.match(/[^\/]+$/)[0]
        description = category.attributes["label"].value
        @@category_mapping.merge!(abbreviation => description)
      end
      @@category_mapping
    end

    attribute :abbreviation, String, tag: 'term'

    def description
      Category.types[abbreviation]
    end

    def long_description
      description ? "#{abbreviation} (#{description})" : abbreviation
    end

  end
end
