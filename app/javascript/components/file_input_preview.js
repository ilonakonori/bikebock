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

// ride photos
const fileInputPreviewRidePhotos = () => {
  // 1.photo
  // edit i.e. photo present
  const photoInput = document.getElementById('ride_photo_1');
  const ph_1 = document.getElementById('ph_1');
  if(ph_1) {
    const p1 = document.getElementById('upload_photo_1');
      if(p1) {
        p1.addEventListener('click', function() {
          photoInput.click();
        })
      }
  }
  if (photoInput) {
    const previewDiv = document.getElementById('previewPhoto1');
    photoInput.addEventListener('change', (event) => {

      const uploadedImage = event.currentTarget.files[0];
      const imageUrl = window.URL.createObjectURL(uploadedImage);
      previewDiv.innerHTML = `<img src='${imageUrl}' width='95' height='70' style='border-radius: 8px;'><i id="upload_photo_1" class="fas fa-times-circle pr"></i>`;

      const phot_1 = document.getElementById('photo_1');
      // not present i.e. new ride
      if(phot_1) {
        photo_1.style.display = 'none';
        const present = document.querySelector('.present');

        if(present) {
          // do nothing
        } else {
          document.getElementById('photo_2').style.display = 'inherit';
          document.getElementById('photo_2').classList.add('present');
        }
      }

      const p1 = document.getElementById('upload_photo_1');
      if(p1) {
        p1.addEventListener('click', function() {
          photoInput.click();
        })
      }
    });
  }

  // 2.photo
  const photoInput2 = document.getElementById('ride_photo_2');
  const ph_2 = document.getElementById('ph_2');
  if(ph_2) {
    const p2 = document.getElementById('upload_photo_2');
      if(p2) {
        p2.addEventListener('click', function() {
          photoInput2.click();
        })
      }
  }

  if (photoInput2) {
    const previewDiv2 = document.getElementById('previewPhoto2');
    photoInput2.addEventListener('change', (event) => {

      const uploadedImage2 = event.currentTarget.files[0];
      const imageUrl2 = window.URL.createObjectURL(uploadedImage2);
      previewDiv2.innerHTML = `<img src='${imageUrl2}' width='95' height='70' style='border-radius: 8px;'><i id="upload_photo_2" class="fas fa-times-circle pr"></i>`;

      const present = document.querySelector('.present');

      if(present) {
        if(present.id === 'photo_2') {
          document.getElementById('photo_2').style.display = 'none';
          document.getElementById('photo_2').classList.remove('present');
          document.getElementById('photo_3').style.display = 'inherit';
          document.getElementById('photo_3').classList.add('present');
        } else {
          // do nothing
        }
      }

      const p2 = document.getElementById('upload_photo_2');
      if(p2) {
        p2.addEventListener('click', function() {
          photoInput2.click();
        })
      }
    });
  }

  // 3.photo
  const photoInput3 = document.getElementById('ride_photo_3');

  const ph_3 = document.getElementById('ph_3');
  if(ph_3) {
    const p3 = document.getElementById('upload_photo_3');
      if(p3) {
        p3.addEventListener('click', function() {
          photoInput3.click();
        })
      }
  }


  if (photoInput3) {
    const previewDiv3 = document.getElementById('previewPhoto3');
    photoInput3.addEventListener('change', (event) => {

      const uploadedImage3 = event.currentTarget.files[0];
      const imageUrl3 = window.URL.createObjectURL(uploadedImage3);
      previewDiv3.innerHTML = `<img src='${imageUrl3}' width='95' height='70' style='border-radius: 8px;'><i id="upload_photo_3" class="fas fa-times-circle pr"></i>`;

      const present = document.querySelector('.present');

      if(present) {
        if(present.id === 'photo_3') {
          document.getElementById('photo_3').style.display = 'none';
          document.getElementById('photo_3').classList.remove('present');
          document.getElementById('photo_done').style.display = 'inherit';
          document.getElementById('photo_done').classList.add('present');
        } else {
          // do nothing
        }
      }
      const p3 = document.getElementById('upload_photo_3');
      if(p3) {
        p3.addEventListener('click', function() {
          photoInput3.click();
        })
      }
    });
  }
};

export { fileInputPreviewAvatar, fileInputPreviewBike, fileInputPreviewRidePhotos };
