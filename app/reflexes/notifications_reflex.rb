# frozen_string_literal: true

class NotificationsReflex < ApplicationReflex
  # Add Reflex methods in this file.
  #
  # All Reflex instances expose the following properties:
  #
  #   - connection - the ActionCable connection
  #   - channel - the ActionCable channel
  #   - request - an ActionDispatch::Request proxy for the socket connection
  #   - session - the ActionDispatch::Session store for the current visitor
  #   - url - the URL of the page that triggered the reflex
  #   - element - a Hash like object that represents the HTML element that triggered the reflex
  #
  # Example:
  #
  #   def example(argument=true)
  #     # Your logic here...
  #     # Any declared instance variables will be made available to the Rails controller and view.
  #   end
  #
  # Learn more at: https://docs.stimulusreflex.com

  def mark_as_read
    notification = Notification.find(element.dataset[:id])
    notification.update(read_at: (notification.read_at ? nil : Time.now))
  end
  def mark_as_unread
    notification = Notification.find(element.dataset[:id])
    notification.update(read_at:  nil)
  end
  def mark_all_as_read
     Notification.update_all read_at: Time.now 
  end
end
