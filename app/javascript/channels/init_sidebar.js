const initSidebar = () => {
  const toggle = document.getElementById('sidebar-toggler');
  const sidebar = document.getElementById('sidebar');
  const bell = document.querySelector('.fas.fa-bell')
  toggle.addEventListener('click', () => {
    if(sidebar.classList.contains('active') && bell.classList.contains('active')) {
      sidebar.classList.remove('active');
      bell.classList.remove('active');
    } else {
      sidebar.classList.add('active');
      bell.classList.add('active');
    }
  });
}

export { initSidebar };
