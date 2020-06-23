# frozen_string_literal: true

module TagsHelper
  include ActsAsTaggableOn
  def tag_names
    ActsAsTaggableOn::Tag.most_used(10).map(&:name)
  end
end
