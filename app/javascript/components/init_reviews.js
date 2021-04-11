const showMyReview = () => {
  const reviewBtn = document.getElementById('my-review-btn');
  const reviewBox = document.getElementById('myReview');

  if(reviewBtn && reviewBox) {
    document.addEventListener('click', function(event) {
      let el = event.target;
      // open when clicked 'show my review'
      if(el.id === 'my-review-btn') {
        reviewBox.style.display = 'inherit';
        reviewBtn.style.display = 'none';
      // close on 'X'
      } else if(el.id === 'closeReview') {
        reviewBox.style.display = 'none';
        reviewBtn.style.display = 'inherit';
      // do nothing when clicking on pop-up
      } else if(el.className === 'mr') {
        // do nothing
      // close when clicked outside of pop-up
      } else {
        reviewBox.style.display = 'none';
        reviewBtn.style.display = 'inherit';
      }
    })
  }
}

const showAllReviews = () => {
  const reviewBtn = document.getElementById('reviews-btn');
  const reviewBox = document.getElementById('reviews');

  if(reviewBtn && reviewBox) {
    document.addEventListener('click', function(event) {
      let el = event.target;
      const ids = [`reviews`, `r-box`, `rd`, `review-card`, `fas fa-star`];
      // open when clicked 'Reviews'
      if(el.id === 'reviews-btn') {
        reviewBox.style.display = 'inherit';
      // close on 'X'
      } else if(el.id === 'closeReviews') {
        reviewBox.style.display = 'none';
      // do nothing when clicking on pop-up
      } else if(ids.includes(el.id) || ids.includes(el.className)) {
        // do nothing
      // close when clicked outside of pop-up
      } else {
        reviewBox.style.display = 'none';
      }
    })
  }
}

export { showMyReview, showAllReviews };
