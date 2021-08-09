#!/bin/bash
cd on-connect && ncu -u && npm install && cd ..
cd on-disconnect && ncu -u && npm install && cd ..
cd get-random-word && ncu -u && npm install && cd ..