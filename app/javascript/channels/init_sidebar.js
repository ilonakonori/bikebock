const initSidebar = () => {
  const toggle = document.getElementById('sidebar-toggler');
  const sidebar = document.getElementById('sidebar');
  toggle.addEventListener('click', () => {
    if(sidebar.classList.contains('active')) {
      sidebar.classList.remove('active');
    } else {
      sidebar.classList.add('active');
    }
  });
}

export { initSidebar };
