#!/usr/bin/env -S just --justfile

# Run GitHub Actions locally (available actions: `pull`, `pull_request`, `schedule`)
github action:
    act {{action}}
# List all available GitHub Actions
github-list:
    act --list
# Run GitHub Action with Job ID
github-job jobID:
    act --job {{jobID}}
