const maxThreePhotos = () => {
  const previewDiv = document.getElementById('previewRide');
  const photos = document.getElementById('ride_photos');
  if (photos) {
    photos.addEventListener('click', (event) => {
      let photosNum = previewDiv.children.length;
      if(photosNum === 3) {
        photos.disabled = true;
        alert("You can only upload a maximum of 3 files");
      }
    });
  }
};

export { maxThreePhotos };
