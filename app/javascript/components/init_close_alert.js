const initCloseAlert = () => {
  const alertInfo = document.querySelector('#content-wrap > div.alert.alert-info.alert-dismissible.fade.show.m-1');
  const alertWarning = document.querySelector('#content-wrap > div.alert.alert-warning.alert-dismissible.fade.show.m-1');

  if(alertInfo) {
    setTimeout(function(){
      alertInfo.style.display = 'none';
    }, 3000);
  }

  if(alertWarning) {
    setTimeout(function(){
      alertWarning.style.display = 'none';
    }, 3000);
  }
}

export { initCloseAlert };
