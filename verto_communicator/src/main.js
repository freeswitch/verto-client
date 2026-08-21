// Single entry point for the app. The import order below is the load order the
// hand-written script tags in the old src/index.html had; it matters, because
// every file here is a pre-module script that registers itself on a global.
import './globals.js';

// Stylesheets, in cascade order.
import 'bootstrap/dist/css/bootstrap.css';
import 'angular-toastr/dist/angular-toastr.css';
import 'angular-tooltips/dist/angular-tooltips.min.css';
import 'datatables/media/css/jquery.dataTables.css';
import 'bootstrap-material-design/dist/css/material.css';
import 'bootstrap-material-design/dist/css/ripples.css';
import './css/verto.css';

// Third-party scripts.
import 'jquery-json/src/jquery.json.js';
import 'angular-gravatar/build/angular-gravatar.js';
import 'bootstrap/dist/js/bootstrap.js';
import 'angular-toastr/dist/angular-toastr.tpls.js';
import 'angular-sanitize';
import 'angular-route';
import 'angular-ui-bootstrap';
import 'angular-prompt/dist/angular-prompt.js';
import 'angular-animate';
import 'angular-cookies';
import 'ngstorage/ngStorage.js';
import 'angular-timer/dist/angular-timer.js';
import 'angular-tooltips/dist/angular-tooltips.min.js';
import 'datatables/media/js/jquery.dataTables.js';
import 'bootstrap-material-design/dist/js/material.js';
import 'bootstrap-material-design/scripts/ripples.js';
import 'angular-translate/dist/angular-translate.js';
import 'angular-translate-loader-static-files/angular-translate-loader-static-files.js';
// Not on npm under these module names, so kept in tree: FBAngular and
// angular-click-outside.
import './vendor/angular-fullscreen.js';
import './vendor/clickoutside.directive.js';

// The verto client library itself.
import '../../js/src/vendor/media-device-id.min.js';
import '../../js/src/jquery.jsonrpcclient.js';
import '../../js/src/jquery.FSRTC.js';
import '../../js/src/jquery.verto.js';

import '../js/3rd-party/getScreenId.js';
import '../js/3rd-party/volume-meter.js';

// The app.
import './vertoApp/vertoApp.module.js';

import './vertoControllers/vertoControllers.module.js';
import './vertoControllers/controllers/SplashScreenController.js';
import './vertoControllers/controllers/BrowserUpgradeController.js';
import './vertoControllers/controllers/ChatController.js';
import './vertoControllers/controllers/ContributorsController.js';
import './vertoControllers/controllers/AboutController.js';
import './vertoControllers/controllers/DialPadController.js';
import './vertoControllers/controllers/InCallController.js';
import './vertoControllers/controllers/LoginController.js';
import './vertoControllers/controllers/MainController.js';
import './vertoControllers/controllers/MenuController.js';
import './vertoControllers/controllers/ModalDialpadController.js';
import './vertoControllers/controllers/ModalWsReconnectController.js';
import './vertoControllers/controllers/ModalLoginInformationController.js';
import './vertoControllers/controllers/SettingsController.js';
import './vertoControllers/controllers/PreviewController.js';
import './vertoControllers/controllers/LoadingController.js';

import './vertoDirectives/vertoDirectives.module.js';
import './vertoDirectives/directives/autofocus.js';
import './vertoDirectives/directives/showControls.js';
import './vertoDirectives/directives/userStatus.js';
import './vertoDirectives/directives/videoTag.js';

import './vertoFilters/vertoFilters.module.js';
import './vertoFilters/filters/picturify.js';

import './vertoService/vertoService.module.js';
import './vertoService/services/vertoService.js';
import './vertoService/services/configService.js';
import './vertoService/services/eventQueueService.js';

import './storageService/storageService.module.js';
import './storageService/services/storage.js';
import './storageService/services/call_history.js';
import './storageService/services/splash_screen.js';
