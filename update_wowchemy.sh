#!/usr/bin/env bash

# Wowchemy Updater
# Checks for available updates and then asks to install any updates.
# https://wowchemy.com/docs/update/
#
# Command: bash ./update_wowchemy.sh

# Check for prerequisites.
if [ ! -d content ]; then
  echo "ERROR: `cd` into your website folder before running this tool."
  exit 1;
fi

# Update the Wowchemy Hugo module
function update_wowchemy () {
  # Update Wowchemy to the latest master version
  echo -e "Updating Wowchemy to the latest master version...\n"
  hugo mod get github.com/wowchemy/wowchemy-hugo-modules/wowchemy/@master
  hugo mod tidy
}

# Perform update
update_wowchemy

echo
echo "If there are breaking changes, the site structure, config, and/or front matter of content" \
"may need upgrading by following the steps in the relevant consecutive release notes."
echo
echo "View the update guide at: https://wowchemy.com/docs/update/"
echo "View the latest release notes at: https://wowchemy.com/updates/"
