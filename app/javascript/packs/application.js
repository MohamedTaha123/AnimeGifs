// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs";
Rails.start();
require("turbolinks").start();
require("@rails/activestorage").start();
require("channels");
require("local-time").start();
// require("jquery");
// import $ from 'jquery';
// global.$ = jQuery;

require('@client-side-validations/client-side-validations');
require('@client-side-validations/simple-form/dist/simple-form.bootstrap4');


import  '../../assets/javascripts/serviceworker-companion.js' ;


window.Rails = Rails;

require('bootstrap');
require('data-confirm-modal');


$(document).on("turbolinks:load", () => {
  $('[data-toggle="tooltip"]').tooltip()
  $('[data-toggle="popover"]').popover()
});



require("trix")
require("@rails/actiontext");

// Web Notifications
Notification.requestPermission().then(function (result) {})


import "controllers"
