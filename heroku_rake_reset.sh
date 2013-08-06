#!/bin/bash

heroku pg:reset DATABASE --confirm aqueous-oasis-2587
heroku run rake db:schema:load
heroku run rake db:seed
echo "Heroku deployment (production) has been wiped and reseeded."
