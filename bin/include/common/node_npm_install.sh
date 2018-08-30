#!/bin/bash

echo "Install node and npm"

\. "$NVM_DIR/nvm.sh"

nvm install node --latest-npm
