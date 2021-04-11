const initRequestForm = () => {
  const requestBtn = document.getElementById('request-btn');
  const requestBox = document.getElementById('myForm');

  if(requestBtn && requestBox) {
    document.addEventListener('click', function(event) {
      let el = event.target;
      const ids = [`myForm`, `f-box`, `new_request`, `request-btn`, `select2-request_ride_date-container`];
      // open when clicked 'show my review'
      if(el.id === 'request-btn') {
        requestBox.style.display = 'inherit';
        requestBtn.style.display = 'none';
      // close on 'X'
      } else if(el.id === 'closeBtn') {
        requestBox.style.display = 'none';
        requestBtn.style.display = 'inherit';
      // do nothing when clicking on pop-up
      } else if(ids.includes(el.id) || el.tagName === `B`) {
        // do nothing
      // close when clicked outside of pop-up
      } else {
        requestBox.style.display = 'none';
        requestBtn.style.display = 'inherit';
      }
    })
  }
}

export { initRequestForm };
