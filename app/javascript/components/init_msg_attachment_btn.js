const initMsgAttachmentBtn = () => {
  const uploadBtn = document.getElementById('upload-btn');
  if(uploadBtn) {
    uploadBtn.addEventListener('click', function() {
      document.getElementById('message_attachment').click();
    })
  }
}

export { initMsgAttachmentBtn };
