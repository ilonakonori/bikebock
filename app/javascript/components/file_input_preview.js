const fileInputPreviewAvatar = () => {
  const photoInput = document.getElementById('user_profile_photo');
  if (photoInput) {
    photoInput.addEventListener('change', (event) => {
      const uploadedImage = event.currentTarget.files[0];
      const imageUrl = window.URL.createObjectURL(uploadedImage);
      const previewDiv = document.getElementById('previewAvatar');
      previewDiv.innerHTML = `<img src='${imageUrl}' width='130' height='100' >`
    });
  }
};

const fileInputPreviewBike = () => {
  const photoInput = document.getElementById('user_bike_photo');
  if (photoInput) {
    photoInput.addEventListener('change', (event) => {
      const uploadedImage = event.currentTarget.files[0];
      const imageUrl = window.URL.createObjectURL(uploadedImage);
      const previewDiv = document.getElementById('previewBike');
      previewDiv.innerHTML = `<img src='${imageUrl}' width='130' height='100' >`
    });
  }
};

export { fileInputPreviewAvatar, fileInputPreviewBike };
