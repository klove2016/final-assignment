// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//= require jquery.min
//= require popper.min
//= require bootstrap


import 'bootstrap/dist/js/bootstrap';
import 'bootstrap/dist/css/bootstrap';

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import $ from 'jquery';



Rails.start()
Turbolinks.start()
ActiveStorage.start()

document.addEventListener("DOMContentLoaded", function() {
  const form = document.querySelector("form[action='/availabilities/compare']");
  const submitBtn = document.getElementById("compare_button");
  
  if (submitBtn) {
    submitBtn.disabled = true;
    
    form.addEventListener("change", function() {
      const checkboxes = form.querySelectorAll("input[type='checkbox']");
      let checkedCount = 0;
      
      checkboxes.forEach(function(checkbox) {
        if (checkbox.checked) {
          checkedCount++;
        }
      });
    
      if (checkedCount >= 2) {
        submitBtn.disabled = false;
      } else {
        submitBtn.disabled = true;
      }
    });
  }
});

