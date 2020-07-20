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
      const user_element = document.getElementById('user-id');
      const user_id = Number(user_element.getAttribute('data-user-id'));
      /*  var node = document.createElement("P"); */
      /* 
      var textnode = document.createTextNode(data.content);

      node.appendChild(textnode); */

      /*  document.getElementById("messages").appendChild(node);
       document.getElementById('chat_message').value = '' */
     

  /*     let html;

      if (user_id === data.content.user_id) {
        html = data.mine
      } else {
        html = data.theirs
      } 
      const messageContainer = document.getElementById('messages')
      messageContainer.innerHTML = messageContainer.innerHTML + html */
     console.log(data);
     if (user_id != data.content.user_id) {
        let html = data.theirs;
        const messageContainer = document.getElementById('messages')
        messageContainer.innerHTML = messageContainer.innerHTML + html
      }  
     
    }
  });

})
