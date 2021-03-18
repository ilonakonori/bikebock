// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";
import flatpickr from 'flatpickr';
import "flatpickr/dist/flatpickr.min.css";

// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';
import { initConversationCable, submitAttachment } from '../channels/conversation_channel';
import { initSidebar } from '../components/init_sidebar';
import { initPresence } from '../channels/init_presence';
import { initPresenceCurrent } from '../channels/init_presence_current';
import { fileInputPreviewAvatar, fileInputPreviewBike } from '../components/file_input_preview';
import { initMsgAttachmentPreview, hideIt } from '../components/init_msg_attachment_preview';


document.addEventListener('turbolinks:load', () => {
  // Call your functions here, e.g:
  // initSelect2();
  fileInputPreviewAvatar();
  fileInputPreviewBike();

  initConversationCable();

  submitAttachment();
  initMsgAttachmentPreview();
  hideIt();

  const sidebar = document.getElementById('sidebar');
  if(sidebar) {
    initSidebar();
  }

  const user = document.getElementById('user');
  if(user) {
    initPresence();
  }

  const c_user = document.getElementById('c_user');
  if(c_user) {
    initPresenceCurrent();
  }


  flatpickr(".flatpickr", {
    mode: "multiple",
    dateFormat: "d.m.Y",
    minDate: new Date().fp_incr(1),
    maxDate: new Date().fp_incr(200)
  })
});

import "controllers"
