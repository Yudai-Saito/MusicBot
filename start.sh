#!/bin/bash

eval "$(pyenv init --path)"
pyenv global 3.5.3
python dockerentry.py