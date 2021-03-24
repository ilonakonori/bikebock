const initPresence = () => {
  const user = document.getElementById('user');
  if(user) {
    const id = user.dataset.onlineId;

    setInterval(function() {
      $.ajax({
        url:  `/users/${id}/presence`,
        type: 'GET'
      })
      .done(function(response){
        //console.log(response);
      })
      console.log(`${id} sent`);
    }, 60000);

    setInterval(function() {
      $.ajax({
        type: "PUT",
        url: `/users/${id}/presence`,
        dataType: "script"
      })
    }, 60000);
  }
}

export { initPresence };
