const showMyReview = () => {
  const reviewBtn = document.getElementById('my-review-btn');

  if(reviewBtn) {
    reviewBtn.addEventListener('click', function() {
      document.getElementById('myReview').style.display = 'inherit';
      reviewBtn.style.display = 'none';
    })
  }

  const reviewBox = document.getElementById('myReview');
  const closeBtn = document.getElementById('closeReview');

  if(reviewBox && closeBtn) {
    closeBtn.addEventListener('click', function() {
      reviewBox.style.display = 'none';
      reviewBtn.style.display = 'inherit';
      //requestBtn.scrollIntoView(false);
    })
  }
}

export { showMyReview };
