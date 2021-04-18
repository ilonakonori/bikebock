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

const fileInputPreviewRide1 = () => {
  const photoInput = document.getElementById('ride_photo_1');
  const currentPhoto = document.getElementById('currentBikePhoto');
  if (photoInput) {
    const previewDiv = document.getElementById('previewPhoto1');
    photoInput.addEventListener('change', (event) => {
      if (currentPhoto) {
        currentPhoto.remove();
      } else {
        //previewDiv.style.paddingTop = '1em';
      }
      const uploadedImage = event.currentTarget.files[0];
      const imageUrl = window.URL.createObjectURL(uploadedImage);
      previewDiv.innerHTML = `<img src='${imageUrl}' width='93' height='70' style='border-radius: 8px; margin: 0 3px;'><p id='p1_remove'>X</p>`;

      document.getElementById('photo_1').style.display = 'none';
      document.getElementById('photo_2').style.display = 'inherit';
    });
  }

  const photoInput2 = document.getElementById('ride_photo_2');
  const currentPhoto2 = document.getElementById('currentBikePhoto2');
  if (photoInput2) {
    const previewDiv2 = document.getElementById('previewPhoto2');
    photoInput2.addEventListener('change', (event) => {
      if (currentPhoto2) {
        currentPhoto2.remove();
      } else {
        //previewDiv2.style.paddingTop = '1em';
      }
      const uploadedImage2 = event.currentTarget.files[0];
      const imageUrl2 = window.URL.createObjectURL(uploadedImage2);
      previewDiv2.innerHTML = `<img src='${imageUrl2}' width='93' height='70' style='border-radius: 8px; margin: 0 3px;'><p id='p2_remove'>X</p>`;

      document.getElementById('photo_2').style.display = 'none';
      document.getElementById('photo_3').style.display = 'inherit';
    });
  }

  const photoInput3 = document.getElementById('ride_photo_3');
  const currentPhoto3 = document.getElementById('currentBikePhoto3');
  if (photoInput3) {
    const previewDiv3 = document.getElementById('previewPhoto3');
    photoInput3.addEventListener('change', (event) => {
      if (currentPhoto3) {
        currentPhoto3.remove();
      } else {
        //previewDiv3.style.paddingTop = '1em';
      }
      const uploadedImage3 = event.currentTarget.files[0];
      const imageUrl3 = window.URL.createObjectURL(uploadedImage3);
      previewDiv3.innerHTML = `<img src='${imageUrl3}' width='93' height='70' style='border-radius: 8px; margin: 0 3px;'><p id='p3_remove'>X</p>`;

      document.getElementById('photo_3').style.display = 'none';
      document.getElementById('photo_done').style.display = 'inherit';
    });
  }

};

export { fileInputPreviewAvatar, fileInputPreviewBike, fileInputPreviewRide1 };
