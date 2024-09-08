#!/bin/bash

./scripts/configure.sh
./scripts/start.sh
./scripts/wait.sh
./scripts/setup_db.sh
./scripts/apply_migration.sh
