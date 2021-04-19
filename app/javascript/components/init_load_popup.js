const initLoadPopup = () => {
  const btnProfile = document.getElementById('new-profile');
  const btnProfileEdit = document.getElementById('updated-profile');
  const btnRide = document.getElementById('new-ride');
  const btnRideEdit = document.getElementById('updated-ride');

  if(btnProfile) {
    btnProfile.addEventListener('click', function() {
      document.getElementById('load-pop').style.display = 'inherit';
    })
  }

  if(btnProfileEdit) {
    btnProfileEdit.addEventListener('click', function() {
      document.getElementById('load-pop').style.display = 'inherit';
    })
  }

  if(btnRide) {
    btnRide.addEventListener('click', function() {
      document.getElementById('load-pop-ride').style.display = 'inherit';
    })
  }

  if(btnRideEdit) {
    btnRideEdit.addEventListener('click', function() {
      document.getElementById('load-pop-ride').style.display = 'inherit';
    })
  }
}

export { initLoadPopup };
