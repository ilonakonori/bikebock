import $ from 'jquery';

const initPresenceCurrent = () => {
  const c_user = document.getElementById('c_user');
  if(c_user) {
    const id = c_user.dataset.conlineId;

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

export { initPresenceCurrent };
