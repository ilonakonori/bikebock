const initAnchorScroll = () => {

  if(window.location.hash) {
    const el = document.querySelector(window.location.hash);
    if(el){
      el.scrollIntoView(false);
      //document.getElementById("messages").scrollTop += 24;
    }
  } else {
    const showPage = document.getElementById("c-show");
    const el = document.getElementById("messages");
    if(showPage && el){
      el.lastElementChild.scrollIntoView(false);
      //el.scrollTop += 24;
    }
  }
}

export { initAnchorScroll };
