#!/bin/bash

set -e

hg id | grep + > /dev/null && { echo "Uncommitted changes found. Commit things first!"; exit; }

bundle exec rake clobber build fat

for gem in pkg/*.gem; do
  gem push $gem
done

hg tag "zstdlib-`ruby -e 'puts Gem::Specification.load(%~zstdlib.gemspec~).version'`-release"

hg push

#