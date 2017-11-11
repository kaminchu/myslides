#!/bin/sh
git clone https://github.com/hakimel/reveal.js.git
cd reveal.js
npm install
cp ../test/index.html ./
