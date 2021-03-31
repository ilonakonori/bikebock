 const initConversationSearch = () => {
  // trigger on enter
  const cSearch = document.getElementById('myConversationSearch');
  if(cSearch) {
    cSearch.addEventListener('keyup', function(event) {
      if (event.keyCode === 13) {
        document.getElementById('myConversationSubmit').click();
      }
    });
  }
  // trigger on btn click
  const searchBtn = document.getElementById('search-conversation-btn');
  if(searchBtn) {
    searchBtn.addEventListener('click', function() {
      document.getElementById('myConversationSubmit').click();
    })
  }
}

export { initConversationSearch };
