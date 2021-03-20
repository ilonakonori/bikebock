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
    }, 5000);
  }
}

export { initPresence };
