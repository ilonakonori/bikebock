const initSearchMsgBtn = () => {
  const searchBtn = document.getElementById('search-msg-btn');
  if(searchBtn) {
    searchBtn.addEventListener('click', function() {
      document.getElementById('mySubmit').click();
    })
  }
}

export { initSearchMsgBtn };
