const initRequestForm = () => {
  const requestBtn = document.getElementById('request-btn');

  if(requestBtn) {
    requestBtn.addEventListener('click', function() {
      document.getElementById('myForm').style.display = 'inherit';
      requestBtn.style.display = 'none';
    })
  }

  const requestBox = document.getElementById('myForm');
  const closeBtn = document.getElementById('closeBtn');

  if(requestBox && closeBtn) {
    closeBtn.addEventListener('click', function() {
      requestBox.style.display = 'none';
      requestBtn.style.display = 'inherit';
      requestBtn.scrollIntoView(false);
    })
  }
}

export { initRequestForm };
