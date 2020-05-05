class WelcomeChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'welcome_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
