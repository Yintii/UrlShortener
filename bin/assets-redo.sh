#!/usr/bin/env bash
# exit on error
set -o errexit

rails assets:clobber

dart compile-sass.dart app/assets/stylesheets/index.scss app/assets/stylesheets/styles.css

rails assets:precompile
rails restart

