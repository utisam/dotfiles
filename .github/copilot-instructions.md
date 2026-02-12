# Copilot Instructions

## Overview

This repository contains dotfiles (configuration files) for Zsh, Vim, Git, SQLite, and IPython, along with utility scripts in `bin/`. The goal is to provide a portable, minimal-dependency environment that works on both Linux and macOS.

## Setup & Commands

- **Zsh**:
  - Requires `coreutils` on macOS (`brew install coreutils`).
- **Git**:
  - The `gitconfig` is designed to be included in the user's main `.gitconfig` via `[include] path = ...`.
  - Requires `diff-highlight` setup on macOS.

## Architecture & Conventions

- **Portability**:
  - Scripts and configs must work on both Linux and macOS.
  - Use conditional checks for OS-specific behavior.
- **Minimal Dependencies**:
  - Avoid requiring external plugin managers (like zplug, Vundle).
  - "One file, one responsibility" - try to keep configs self-contained.
- **Usability**:
  - Settings should be beginner-friendly (e.g., intuitive autocomplete).
  - Avoid overly complex or "magical" configurations that are hard to debug or explain.
- **Scripts**:
  - Located in `bin/`. Can be Bash or Zsh. Ensure they are executable.
