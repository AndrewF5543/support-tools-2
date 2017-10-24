#!/bin/bash

tar -czvf $1 -C /tmp/ threatstack_diagnostics || ( echo "Failed to generate tarball! Exiting" ; exit 1 )
