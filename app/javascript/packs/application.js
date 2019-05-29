// app/javascript/packs/application.js
// Requiring CSS! Path is relative to ./node_modules
import $ from 'jquery'
import "bootstrap";
import 'select2/dist/css/select2.css';
import { initSlider } from '../components/init_slider';
import { initSelect2 } from '../components/init_select2';

initSelect2('select2');
initSelect2('js-example-basic-multiple');
initSlider();



// import { initAutocomplete } from '../plugins/init_autocomplete';
// initAutocomplete();
