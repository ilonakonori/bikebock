const initProfilePhotoBtn = () => {
  const uploadBtn = document.getElementById('photo-btn');
  if(uploadBtn) {
    uploadBtn.addEventListener('click', function() {
      document.getElementById('user_profile_photo').click();
    })
  }
}

export { initProfilePhotoBtn };
