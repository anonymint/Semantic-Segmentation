#!/bin/bash

if [ ! -d ../data ]; then
    mkdir ../data
    (cd ../data && wget https://s3-us-west-1.amazonaws.com/udacity-selfdrivingcar/advanced_deep_learning/data_road.zip)
    (cd ../data && unzip -qq data_road.zip)
fi

