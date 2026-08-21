// The verto library, the AngularJS plugins and the vendored jQuery plugins are
// all pre-module scripts: they read $, jQuery, angular, moment,
// humanizeDuration and md5 off window at evaluation time. ESM evaluates
// imported modules before the importing module's body, so these assignments
// have to live in their own module that is imported first - see main.js.
import './jquery-global.js';

import angular from 'angular';
import moment from 'moment';
import humanizeDuration from 'humanize-duration';
import md5 from 'blueimp-md5';

window.angular = window.angular || angular;
window.moment = moment;
window.humanizeDuration = humanizeDuration;
window.md5 = md5;
