#!/bin/bash
# Copying and distribution of this file, with or without modification,
# are permitted in any medium without royalty provided the copyright
# notice and this notice are preserved.  This file is offered as-is,
# without any warranty.
set -e
if [[ -r .travis_ci_gh_pages_deploy_key ]]; then
    if [[ -z "${DEPLOY_DOC_TO_REPOSITORY}" ]]; then
        DEPLOY_DOC_TO_REPOSITORY="${TRAVIS_REPO_SLUG}"
    fi
    chmod 600 .travis_ci_gh_pages_deploy_key
    eval `ssh-agent -s`
    ssh-add .travis_ci_gh_pages_deploy_key < /dev/null
    rm -f .travis_ci_gh_pages_deploy_key
    rm -Rf $HOME/gh-pages
    git clone --depth 1 git@github.com:${DEPLOY_DOC_TO_REPOSITORY}.git --branch=gh-pages $HOME/gh-pages
    BUILT_DOCS_DIR=$TRAVIS_BUILD_DIR/$DEPLOY_DOC_FROM_DIRECTORY
    cd $HOME/gh-pages
    touch .nojekyll
    rm -Rf ./${DEPLOY_DOC_TO_DIRECTORY}/*
    mkdir -p ./${DEPLOY_DOC_TO_DIRECTORY}
    cp -R $BUILT_DOCS_DIR/* ./${DEPLOY_DOC_TO_DIRECTORY}/
    git add --all .
    git config user.name "Travis Deployment Script"
    git config user.email "deploy@travis-ci.org"
    if git commit -m "Automatic upload of documentation built from ${TRAVIS_COMMIT}"; then
	git push origin gh-pages
    fi
    rm -Rf $HOME/gh-pages
    exit
fi
echo "Error in docmumentation deployment: .travis_ci_gh_pages_deploy_key not found"
exit 1
