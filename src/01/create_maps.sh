#!/bin/bash

declare -A dir_map

create_map dir_map $letters_dirs $size_let_dirs

declare -A file_map

create_map file_map $filename $len_filename