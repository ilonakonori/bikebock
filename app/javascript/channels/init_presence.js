const initPresence = () => {
  const id = document.getElementById('user').dataset.onlineId;
  console.log(id)

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

export { initPresence };
