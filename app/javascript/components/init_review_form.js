const initReviewForm = () => {
  const reviewBtn = document.getElementById('review-btn');
  const reviewBox = document.getElementById('myReviewForm');

  if(reviewBtn && reviewBox) {
    document.addEventListener('click', function(event) {
      let el = event.target;
      const ids = [`myReviewForm`, `text optional`, `select required`, `review_content`, `review_rating`];

      // open when clicked 'write review'
      if(el.id === 'review-btn') {
        reviewBox.style.display = 'inherit';
      // close on 'X'
      } else if(el.id === 'closeReviewBtn') {
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

export { initReviewForm };
