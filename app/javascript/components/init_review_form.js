const initReviewForm = () => {
  const reviewBtn = document.getElementById('review-btn');
  if(reviewBtn) {
    reviewBtn.addEventListener('click', function() {
      document.getElementById('myReviewForm').style.display = 'inherit';
    })
  }

  const reviewBox = document.getElementById('myReviewForm');
  const closeBtn = document.getElementById('closeReviewBtn');
  if(reviewBox && closeBtn) {
    closeBtn.addEventListener('click', function() {
      reviewBox.style.display = 'none';
    })
  }
}

export { initReviewForm };
