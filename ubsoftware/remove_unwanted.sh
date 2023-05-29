#!/bin/bash
Remove_Unwanted(){
    dpkg -l | grep -q aisleriot && sudo apt-get purge -y aisleriot
    dpkg -l | grep -q gnome-sudoku && apt-get purge -y gnome-sudoku
    dpkg -l | grep -q gnome-mines && apt-get purge -y gnome-mines
    dpkg -l | grep -q gnome-mahjongg && apt-get purge -y gnome-mahjongg
    dpkg -l | grep -q rhythmbox && apt-get purge -y rhythmbox
    dpkg -l | grep -q simple-scan && apt-get purge -y simple-scan
    dpkg -l | grep -q cheese && apt-get purge -y cheese
    apt-get -y autoremove
}