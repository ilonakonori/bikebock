const initNotifications = () => {
  const id = document.getElementById('note').dataset.noteId;

  setInterval(function() {
    $.ajax({
    url:  `/users/${id}/unread`,
    type: 'GET'
    })
    .done(function(response){
      //console.log(response);
    })
    console.log(`sent notifications ${id}`);
  }, 5000);

}

export { initNotifications };
