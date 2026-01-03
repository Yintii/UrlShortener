#!/usr/bin/env bash
# exit on error
set -o errexit

rails assets:clobber
rails assets:precompile
rails restart