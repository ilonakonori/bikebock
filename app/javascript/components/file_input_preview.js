const fileInputPreviewAvatar = () => {
  const photoInput = document.getElementById('user_profile_photo');
  const currentPhoto = document.getElementById('currentUserPhoto');
  if (photoInput) {
    const previewDiv = document.getElementById('previewAvatar');
    photoInput.addEventListener('change', (event) => {
      if (currentPhoto) {
        currentPhoto.remove();
      } else {
        previewDiv.style.paddingTop = '1em';
      }
      const uploadedImage = event.currentTarget.files[0];
      const imageUrl = window.URL.createObjectURL(uploadedImage);
      previewDiv.innerHTML = `<img src='${imageUrl}' width='100' height='100' style='border-radius: 50%; box-shadow: 3px 4px 5px 0px rgba(0, 0, 0, 0.38);' >`;
    });
  }
};

const fileInputPreviewBike = () => {
  const photoInput = document.getElementById('user_bike_photo');
  const currentPhoto = document.getElementById('currentBikePhoto');
  if (photoInput) {
    const previewDiv = document.getElementById('previewBike');
    photoInput.addEventListener('change', (event) => {
      if (currentPhoto) {
        currentPhoto.remove();
      } else {
        previewDiv.style.paddingTop = '1em';
      }
      const uploadedImage = event.currentTarget.files[0];
      const imageUrl = window.URL.createObjectURL(uploadedImage);
      previewDiv.innerHTML = `<img src='${imageUrl}' width='280' height='140' style='border-radius: 16px;'>`;
    });
  }
};

export { fileInputPreviewAvatar, fileInputPreviewBike };
