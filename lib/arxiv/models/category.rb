module Arxiv
  class Category
    include HappyMapper

    @@category_mapping = {}

    def self.types
      return @@category_mapping unless @@category_mapping.empty?

      url = ::URI.parse("http://arxiv-api.googlegroups.com/attach/5e540c5aa16cd1a1/servicedocument.xml?gda=GkSq-0UAAACv8MuSQ9shr-Fm8egpLVNUyoJFgZHB152DBrQX4ANeXa_N1TJg9KB-8oF-EwbRpI6O3f1cykW9hbJ1ju6H3kglGu1iLHeqhw4ZZRj3RjJ_-A&view=1&part=2")
      xml = ::Nokogiri::XML(open(url)).remove_namespaces!
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
