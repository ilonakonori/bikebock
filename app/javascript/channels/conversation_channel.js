import consumer from "./consumer";

const initConversationCable = () => {
  const messagesContainer = document.getElementById('messages');

  if (messagesContainer) {
    const id = messagesContainer.dataset.conversationId;
    consumer.subscriptions.create({ channel: "ConversationChannel", id: id }, {
      received(data) {
        console.log(data); // called when data is broadcast in the cable
        const currentUserId = Number(messagesContainer.getAttribute("data-current-user-id"));
        let html = "";
        if (currentUserId === data.message.sender_id) {
          html = data.sender
        } else {
          html = data.receiver
        }
        messagesContainer.insertAdjacentHTML('beforeend', html);
        messagesContainer.lastElementChild.scrollIntoView(false);
        messagesContainer.scrollTop += 24;

        /*
        const uploading = document.getElementById('loadDiv');
        if(uploading) {
          uploading.style.display = 'none';
        } */
      },
    });
  }
}

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
