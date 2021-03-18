const initBookmarks = () => {
  const bookmarks = document.querySelectorAll('.rides div:nth-child(1) > div:nth-child(1) > a > i');
  if(bookmarks) {
    for(let i = 0; i < bookmarks.length; i++) {
      bookmarks[i].addEventListener('click', function() {
        const location = window.location.href; //change location for production!
        if (location == 'http://localhost:3000/users/bookmarks') {
          const id = bookmarks[i].dataset.rideId.replace('b-', '');
          console.log(id)
          document.getElementById('ride-' + id).remove();
        } else {
          if (bookmarks[i].classList.contains('far')) {
            bookmarks[i].classList.remove('far');
            bookmarks[i].classList.add('fas');
            bookmarks[i].title = 'Unbookmark';
          } else {
            bookmarks[i].classList.remove('fas');
            bookmarks[i].classList.add('far');
            bookmarks[i].title = 'Bookmark';
          }
        }
      });
    }
  }
}

export { initBookmarks };
