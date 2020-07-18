import consumer from "./consumer"
document.addEventListener('turbolinks:load', () => {
  const conversation_element = document.getElementById('conversation-id');
  const conversation_id = conversation_element.getAttribute('data-conversation-id');

  consumer.subscriptions.create({
    channel: "ChatroomChannel",
    conversation_id: conversation_id
  }, {
    connected() {
      console.log("connected to " + conversation_id);
    },

    disconnected() {
      console.log('disconnected from ' + conversation_id);
    },

    received(data) {

      var node = document.createElement("P");

      console.log(data);

      var textnode = document.createTextNode(data.content);

      node.appendChild(textnode);

      document.getElementById("new_message").appendChild(node);
      document.getElementById('chat_message').value = ''
    }
  });

})
