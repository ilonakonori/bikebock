const initCloseAlert = () => {
  const alerts = document.getElementsByClassName('alert');
  if(alerts) {
    for(let i = 0; i < alerts.length; i++) {
      setTimeout(function(){
        alerts[i].style.display = 'none';
      }, 3000);
    }
  }
}

export { initCloseAlert };
