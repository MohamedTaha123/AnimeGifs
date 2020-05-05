import consumer from "./consumer"

consumer.subscriptions.create("WelcomeChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    if (Notification.permission === 'granted') {
      var title = 'Web Notifications'
      var body = data
      var options = { body: body }
      new Notification(title, options)
    }
  }
});
