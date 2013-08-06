#!/bin/bash

rake db:drop:all
rake db:create:all
rake db:schema:load
rake db:seed
rake db:test:prepare
echo "Development and test databases have been reset and seeded."
