const initPresence = () => {
  const id = document.getElementById('user').dataset.onlineId;
  const cid = document.getElementById('c_user').dataset.conlineId;

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


 setInterval(function() {
    $.ajax({
    url:  `/users/${cid}/presence`,
    type: 'GET'
    })
    .done(function(response){
      //console.log(response);
    })
    console.log(`presence cid ${cid} sent`);
  }, 5000);

}

export { initPresence };
