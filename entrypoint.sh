#!/bin/sh
set -e

if [ -n "${GITHUB_WORKSPACE}" ]; then
  cd "${GITHUB_WORKSPACE}" || exit
fi

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

dotnet build -c Debug -v detailed -clp:NoSummary --nologo \
  | reviewdog -efm="\ %#%f(%l\\\,%c):\ %m" -efm="%#%f\ :\ %m" -name="Dotnet" -reporter="${INPUT_REPORTER:-github-pr-check}" -level="${INPUT_LEVEL}"