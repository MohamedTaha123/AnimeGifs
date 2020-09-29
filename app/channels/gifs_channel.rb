class GifsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "gifs_channel"
  end

  def unsubscribed
    stop_all_streams
  end
end
