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

  // close requestBox when clicked outside
  if(requestBox) {
    document.addEventListener('click', function(event) {
      let el = event.target;
      const ids = [`myForm`, `f-box`, `new_request`, `request-btn`, `select2-request_ride_date-container`];
      if(ids.includes(el.id) || el.tagName === `B`) {
        // do nothing
      } else {
        requestBox.style.display = 'none';
        requestBtn.style.display = 'inherit';
      }
    })
  }
}

export { initRequestForm };
