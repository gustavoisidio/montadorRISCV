#!/bin/bash
# DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# cd / && touch tt.txt && ./run
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd ${__dir}/ && touch instructions.txt && touch instructions.mif && ./source