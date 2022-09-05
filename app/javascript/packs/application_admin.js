import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

require("jquery")
import "bootstrap"
require("packs/owl.carousel.min")
require("packs/owl.carousel")
require("packs/easing.min")
require("./easing")
require("./main")
require("./contact")
require("./jqBootstrapValidation")
