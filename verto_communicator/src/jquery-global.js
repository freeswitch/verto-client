// Must be its own module, imported before anything that touches angular:
// AngularJS decides between full jQuery and its built-in jqLite while angular.js
// is being evaluated, and ESM runs a module's imports before its own body.
import jQuery from 'jquery';

window.$ = window.jQuery = jQuery;
