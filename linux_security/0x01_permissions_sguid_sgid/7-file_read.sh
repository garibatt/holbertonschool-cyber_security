#!/bin/bash
find /path/to/directory -type f -exec chmod o-wx,o+r {} \;
