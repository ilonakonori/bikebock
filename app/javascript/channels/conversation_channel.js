import consumer from "./consumer";
const initConversationCable = () => {
  const messagesContainer = document.getElementById('messages');

  if (messagesContainer) {
    const id = messagesContainer.dataset.conversationId;
    consumer.subscriptions.create({ channel: "ConversationChannel", id: id }, {
      received(data) {
        console.log(data); // called when data is broadcast in the cable
        //const messageElement = document.getElementById('user-id');
        //const currentUserId =  Number(messageElement.getAttribute("data-user-id"));
        const currentUserId = Number(messagesContainer.getAttribute("data-current-user-id"));
        let html = "";
        if (currentUserId === data.message.sender_id) {
          html = data.sender
        } else {
          html = data.receiver
        }
        messagesContainer.insertAdjacentHTML('beforeend', html);

        messagesContainer.scrollTop += 70;
        // if (senderId !== current_user.id) {
        //   receivedMessage.classList.remove("chat-box-sender")
        // }
      },
    });
  }
}

/*
const insertIntoDOM = (messageHTML, currentUserId, messages) => {
  const message = document.createElement('div');
  message.innerHTML = messageHTML;

  if (message.dataset.senderId === currentUserId) {
    message.firstChild.classList.add('message-sent');
    message.firstChild.querySelector(':nth-child(1)').classList.add('msg-sent');

  } else {
    message.firstChild.classList.add('message-received');
    message.firstChild.querySelector(':nth-child(1)').classList.add('msg-received');
  }

  messages.insertAdjacentElement('beforeend', message);

  // blinking... :/
  //setTimeout(function() {
    //messages.lastChild.scrollIntoView(false);
    message.scrollIntoView(false);
    messages.scrollTop += 40;
  //}, 400)

  const uploading = document.getElementById('loadDiv');
  if(uploading) {
    uploading.style.display = 'none';
  }
}

const initConversationCable = () => {
  const messagesContainer = document.getElementById('messages');
  if (messagesContainer) {
    const id = messagesContainer.dataset.conversationId;
    //const currentUserId = messagesContainer.dataset.currentUserId;
    const currentUserId = Number(messageContainer.getAttribute("data-current-user-id"));

    consumer.subscriptions.create({ channel: "ConversationChannel", id: id }, {
      received(messageHTML) {
        insertIntoDOM(messageHTML, currentUserId, messagesContainer);
      },
    });
  }
}
*/
// submit attachment on attachment input
const submitAttachment = () => {
  const attachmentInput = document.getElementById('message_attachment');
  if(attachmentInput) {
    attachmentInput.addEventListener('input', (event) => {
      document.querySelector('#new_message > button').click();
      document.getElementById('loadDiv').style.display = 'inherit';
    });
  }
}


// submit msg on enter (enter + shift = new line)
const submitOnEnter = () => {
  const messageInput = document.getElementById("message_content");
  if(messageInput) {
    messageInput.addEventListener("keydown", (e) => {
      if(e.key === "Enter" && !e.shiftKey) {
        e.preventDefault();
        document.querySelector('#new_message > button').click();
      }
    })
  }
};

export { initConversationCable, submitAttachment, submitOnEnter };
