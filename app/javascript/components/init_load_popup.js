const initLoadPopup = () => {
  const btnProfile = document.getElementById('new-profile');
  const btnRide = document.getElementById('new-ride');

  if(btnProfile) {
    btnProfile.addEventListener('click', function() {
      document.getElementById('load-pop').style.display = 'inherit';
    })
  }
  if(btnRide) {
    btnRide.addEventListener('click', function() {
      document.getElementById('load-pop-ride').style.display = 'inherit';
    })
  }
}

export { initLoadPopup };
