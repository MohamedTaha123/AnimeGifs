class GifsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "gifs_channel"
  end


end
