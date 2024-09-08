#!/bin/bash

./scripts/wipe.sh && cd ..
./scripts/setup_db.sh && cd ..
./scripts/apply_migration.sh && cd ..
