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
import { initConversationCable, submitAttachment, submitOnEnter } from '../channels/conversation_channel';
import { initSidebar } from '../components/init_sidebar';
import { initPresence } from '../components/init_presence';
import { initPresenceCurrent } from '../components/init_presence_current';
import { fileInputPreviewAvatar, fileInputPreviewBike, fileInputPreviewRidePhotos } from '../components/file_input_preview';
import { initMsgAttachmentPreview, hideIt } from '../components/init_msg_attachment_preview';
import { initBookmarks } from '../components/init_bookmarks';
import { initCloseAlert } from '../components/init_close_alert';
import { initMsgAttachmentBtn } from '../components/init_msg_attachment_btn';
import { initRequestForm } from '../components/init_request_form';
import { initProfilePhotoBtn } from '../components/init_profile_photo_btn';
import { initRequestsDropdown } from '../components/init_requests_dropdown';
import { initReviewForm } from '../components/init_review_form';
import { initStarRating } from '../plugins/init_star_rating';
import { initSelect2 } from '../plugins/init_select2';
import { autocompleteSearchConversations } from '../plugins/autocomplete_search_conversations';
import { autocompleteSearchMessages } from '../plugins/autocomplete_search_messages';
import { showMyReview, showAllReviews } from '../components/init_reviews';
import { initAnchorScroll } from '../components/init_anchor_scroll';
import { initBlockingsDropdown } from '../components/init_blockings_dropdown';
import { initSweetalert } from '../plugins/init_sweetalert';
import { initLoadPopup } from '../components/init_load_popup';
import { styleSelect2 } from '../components/style_select2';



document.addEventListener('turbolinks:load', () => {
  // Call your functions here, e.g:
  initSelect2();
  fileInputPreviewAvatar();
  fileInputPreviewBike();

  fileInputPreviewRidePhotos();

  initProfilePhotoBtn();
  initRequestsDropdown();
  initReviewForm();
  initStarRating();
  autocompleteSearchConversations();
  autocompleteSearchMessages();
  showMyReview();
  showAllReviews();

  initConversationCable();

  styleSelect2();

  initAnchorScroll();

  initBlockingsDropdown();
  initLoadPopup();
  initBookmarks();
  initMsgAttachmentBtn();
  submitAttachment();
  submitOnEnter();
  initMsgAttachmentPreview();
  hideIt();
  initCloseAlert();
  initSidebar();
  initRequestForm();
  initPresence();
  initPresenceCurrent();

  flatpickr(".flatpickr", {
    mode: "multiple",
    dateFormat: "d.m.Y",
    minDate: new Date().fp_incr(1),
    maxDate: new Date().fp_incr(200)
  })

  initSweetalert('#sweet-alert-demo', {
    title: "Are you sure?",
    text: "This action cannot be reversed",
    icon: "warning",
    buttons: [true, "Do it!"],
    className: `${document.cookie.replace('theme=', '')}`
  }, (value) => {
    if (value) {
      const link = document.querySelector('#delete-link');
      link.click();
    }
  });
});

import "controllers"
