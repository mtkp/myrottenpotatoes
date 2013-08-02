#!/bin/bash

rake db:drop:all
rake db:create:all
rake db:migrate
rake db:seed
rake db:test:prepare
echo "Database has been reset, populated, and prepared"
