#!/bin/bash
shopt -s expand_aliases
alias links='links -http-proxy 10.200.36.1:3128 -ftp-proxy 10.200.36.1:3128 -https-proxy 10.200.36.1:3128'
shopt -u expand_aliases
