#!/bin/sh

chflags -R nouchg Resources/img
chflags -R nouchg Output/img
rm -r Resources/img
rm -r Output/img
cd Resources && ln -s /Volumes/BenPortData/theskinny-media/img img
cd ..
cd Output && ln -s /Volumes/BenPortData/theskinny-media/img img
cd ..
cd Output && ln -s /Volumes/BenPortData/theskinny-media/dailyphotostore dailyphotostore
cd ..
cd Resources && ln -s /Volumes/BenPortData/theskinny-media/sound sound
cd ..
cd Output && ln -s /Volumes/BenPortData/theskinny-media/sound sound
cd ..
cd Resources && ln -s /Volumes/BenPortData/theskinny-media/dailyphotostore dailyphotostore
