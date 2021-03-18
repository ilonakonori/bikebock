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
          image.src = imgs[i].src;
          image.classList.add('prev');
          prevDiv.appendChild(image);
        }
      });
    }
  }
}

const hideIt = () => {
  const prevDiv = document.getElementById('prevDiv');
   if(prevDiv) {
    prevDiv.addEventListener('click', function() {
      prevDiv.removeChild(prevDiv.childNodes[0]);
    });
  }
}

export { initMsgAttachmentPreview, hideIt };
