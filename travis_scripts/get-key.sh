#!/bin/bash
set -e
rm -rf $HOME/deploy_key
git clone --depth 1 https://github.com/${TRAVIS_REPO_SLUG}.git --branch=deploy_key $HOME/deploy_key
cp $HOME/deploy_key/.travis_ci_gh_pages_deploy_key.enc .
rm -rf $HOME/deploy_key
