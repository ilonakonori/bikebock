const initBlockingsDropdown = () => {
  const myDropdownBtn = document.getElementById('blockedDropdown');
  const dropdown = document.getElementById('blockedDropdownMenu');
  if(myDropdownBtn && dropdown) {
    myDropdownBtn.addEventListener('click', function() {
      if(dropdown.classList.contains('hide')) {
        dropdown.classList.remove('hide');
        dropdown.classList.add('show');
      } else {
        dropdown.classList.remove('show');
        dropdown.classList.add('hide');
      }
    })
  }
}

export { initBlockingsDropdown };
