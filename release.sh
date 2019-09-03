#!/bin/bash

set -e

git diff --quiet || { echo "Uncommitted changes found. Commit things first!"; exit; }

bundle exec rake clobber build fat

for gem in pkg/*.gem; do
  gem push $gem
done

git tag "zstdlib-`ruby -e 'puts Gem::Specification.load(%~zstdlib.gemspec~).version'`-release"

git push --follow-tags

#