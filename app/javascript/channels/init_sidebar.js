const initSidebar = () => {
  const toggle = document.getElementById('sidebar-toggler');
  const sidebar = document.getElementById('sidebar');
  //const bell = document.querySelector('.fas.fa-bell');
  const box = document.querySelector('.sidebar-box');

  toggle.addEventListener('click', () => {
    if(sidebar.classList.contains('active') && box.classList.contains('active')) {
      sidebar.classList.remove('active');
      box.classList.remove('active');
      /*
      if(bell) {
        if(bell.classList.contains('active')) {
          bell.classList.remove('active');
        }
      } */

    } else {
      sidebar.classList.add('active');
     /* if(bell) {
        bell.classList.add('active');
      } */

      box.classList.add('active');

    }
  });
}

export { initSidebar };
