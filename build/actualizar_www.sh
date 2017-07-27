#!/bin/bash

jekyll build
sudo rm -r /usr/share/nginx/www
sudo cp -r build /usr/share/nginx/www

