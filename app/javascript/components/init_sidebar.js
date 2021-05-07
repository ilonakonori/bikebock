const initSidebar = () => {
  const sidebar = document.getElementById('sidebar');

  if(sidebar) {
    const toggle = document.getElementById('sidebar-toggler');
    const box = document.querySelector('.sidebar-box');
    const footerBox = document.querySelector('.sidebar-footer-box');

    toggle.addEventListener('click', () => {
      if(sidebar.classList.contains('active')
        && box.classList.contains('active')
        && footerBox.classList.contains('active')
        ) {
          sidebar.classList.remove('active');
          box.classList.remove('active');
          footerBox.classList.remove('active');
          toggle.classList.remove('fa-times');
          toggle.classList.add('fa-bars');
      } else {
        sidebar.classList.add('active');
        box.classList.add('active');
        toggle.classList.remove('fa-bars');
        toggle.classList.add('fa-times');
        footerBox.classList.add('active');
      }
    });

    // close sidebar when clicking outside
    document.addEventListener('click', function(event) {
      let el = event.target;
      const ids = [`sidebar`,`sidebar-toggler`, `s-el`,`myDropdown`, `myDropdownMenu`, `nav-item`, `nav-item active`, `sidebar-box`, `sidebar-footer-box`];

      if(ids.includes(el.id) || ids.includes(el.className)) {
        // do nothing
      } else {
        sidebar.classList.remove('active');
        box.classList.remove('active');
        footerBox.classList.remove('active');
      }
    })
  }
}

export { initSidebar };
