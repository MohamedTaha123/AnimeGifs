# frozen_string_literal: true

class FindReposAndAssignJob < ApplicationJob
  queue_as :default

  def perform(user)
    new_github_instance = Github.new 
    if user.services.present?
      user.update(repos_hash: (new_github_instance.repos.list user: user.username))
    elsif user.name.present?
      user.update(repos_hash: (new_github_instance.repos.list user: user.name))
    end
    
    
  rescue StandardError => e
    Rails.logger.error("Error on Job : #{e}")
  end
end
