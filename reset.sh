#!/bin/bash

./scripts/wipe.sh 
./scripts/wait.sh
./scripts/setup_db.sh
./scripts/apply_migration.sh
