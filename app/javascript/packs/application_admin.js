import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import jquery from 'jquery';
window.$ = window.jquery = jquery;

import "bootstrap";
//= require popper

import "packs/main";
