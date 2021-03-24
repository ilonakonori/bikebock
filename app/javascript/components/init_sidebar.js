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
      } else {
        sidebar.classList.add('active');
        box.classList.add('active');
        footerBox.classList.add('active');
      }
    });
  }
}

export { initSidebar };
