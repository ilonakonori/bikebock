const initRequestsDropdown = () => {
  const myDropdownBtn = document.getElementById('myDropdown');
  if(myDropdownBtn) {
    myDropdown.addEventListener('click', function() {
      if(myDropdown.classList.contains('mb')) {
        myDropdown.classList.remove('mb');
        myDropdown.classList.add('mb-o');
        document.getElementById('myDropdownMenu').style.display = 'inherit';
      } else {
        myDropdown.classList.add('mb');
        myDropdown.classList.remove('mb-o');
        document.getElementById('myDropdownMenu').style.display = 'none';
      }
    })
  }
}

export { initRequestsDropdown };
