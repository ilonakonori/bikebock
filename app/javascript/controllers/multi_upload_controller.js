import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["files"]

  addFile(event) {
  // Grab some references for later
    const originalInput = event.target;
    const originalParent = originalInput.parentNode;
    console.log('hi')

    // Create an element that contains our input element
    const selectedFile = document.createElement("div");
    selectedFile.className = "selected-file";
    selectedFile.append(originalInput);

    // Create label (the visible part of the new input element) with the name of
    // the selected file.
    // better w/o label
    //var labelNode = document.createElement("label");
    //var textElement = document.createTextNode(originalInput.files[0].name);
    //labelNode.appendChild(textElement);
    //selectedFile.appendChild(labelNode);

    // Add the selected file to the list of selected files
    this.filesTarget.append(selectedFile);

    // Create a new input field to use going forward
    const newInput = originalInput.cloneNode();

    // Clear the filelist - some browsers maintain the filelist when cloning,
    // others don't
    newInput.value = "";

    // Add it to the DOM where the original input was
    originalParent.append(newInput);

    // Preview
    const previewDiv = document.getElementById('previewRide');
    const uploadedImage = originalInput.files[0];
    const imageUrl = window.URL.createObjectURL(uploadedImage);
    const previewImg = document.createElement("div");
    previewImg.innerHTML = `<img src='${imageUrl}' width='100' height='70' >`;
    previewDiv.appendChild(previewImg);

    // max 3 photos
    let photosNum = previewDiv.children.length;
    console.log(photosNum);
    if(photosNum >= 3) {
      newInput.disabled = true;
      setTimeout(function() { alert("You can only upload a maximum of 3 files"); }, 1000);
    }
  }
}

