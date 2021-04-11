import consumer from "./consumer";

const initMsgAttachmentPreview = () => {
  const imgs = document.getElementsByClassName('imgs');
  const prevDiv = document.getElementById('prevDiv');

  if(imgs && prevDiv) {
    for(let i = 0; i < imgs.length; i++) {
      imgs[i].addEventListener('click', function() {
        if(prevDiv.hasChildNodes()) {
          prevDiv.removeChild(prevDiv.childNodes[0]);
        } else {
          const image = document.createElement('img');
          image.src = imgs[i].src.replace(/c_fill,h_70,w_70/g, 'c_fit,w_220');
          image.classList.add('prev');
          prevDiv.appendChild(image);
        }
      });
    }
  }
}


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
        initMsgAttachmentPreview();
        messagesContainer.lastElementChild.scrollIntoView(false);
        //messagesContainer.scrollTop += 24;
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
