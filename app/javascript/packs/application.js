// app/javascript/packs/application.js
// Requiring CSS! Path is relative to ./node_modules
import $ from 'jquery'
import "bootstrap";
import 'select2/dist/css/select2.css';
import 'nouislider/distribute/nouislider.css';
import { initSlider } from '../components/init_slider';
import { initOneHandleSlider } from '../components/init_slider';
import { initSelect2 } from '../components/init_select2';
import '../components/jobot'

initSelect2('select2');
initSelect2('js-example-basic-multiple');
// initSlider('compensation_slider');
initOneHandleSlider('experience_slider');

// import { initAutocomplete } from '../plugins/init_autocomplete';
// initAutocomplete();

// DOWN ARROW INDEX PAGE

$(function() {
  $('a[href*=#]').on('click', function(e) {
    e.preventDefault();
    $('html, body').animate({ scrollTop: $($(this).attr('href')).offset().top}, 500, 'linear');
  });
});

// LOADING PAGE JS BELOW


  console.log('mages');
  if (images) {
  var counter = 0;
  changeImage(counter)

  // Start the changing images
  setInterval(function() {
    if(counter == images.length) {
      counter = 0;
    }

    changeImage(counter);
    counter++;
  }, 4000);

  // // Set the percentage off
  // loading();
}
;

function changeImage(counter) {
  document.querySelector(".loading-message").innerHTML=images[counter]
}

// function loading(){
//   var num = 0;

//   for(i=0; i<=100; i++) {
//     setTimeout(function() {
//       $('.loader span').html(num+'%');

//       if(num == 100) {
//         loading();
//       }
//       num++;
//     },i*120);
//   };



