#!/bin/bash

set -e

git diff --quiet || { echo "Uncommitted changes found. Commit things first!"; exit; }

rm -rf pkg

bundle exec rake clobber build gem:all

for gem in pkg/*.gem; do
  gem push $gem
done

git push

git tag "zstdlib-`ruby -e 'puts Gem::Specification.load(%~zstdlib.gemspec~).version'`-release"

git push --tags

#