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
initSlider('compensation_slider');
initOneHandleSlider('experience_slider');

// import { initAutocomplete } from '../plugins/init_autocomplete';
// initAutocomplete();
