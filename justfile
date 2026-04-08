alias l := lint

default: ci

ci: lint

lint: lint-markdown lint-vale

[group('lint')]
lint-markdown:
	markdownlint-cli2

[group('lint')]
lint-markdown-staged:
	@git diff --cached --name-only -z --diff-filter=ACMR -- '*.md' | xargs -0 -r markdownlint-cli2

[group('lint')]
lint-vale:
	@find . -name '*.md' -not -path './.git/*' -print0 | xargs -0 -r vale --config=.vale.ini

[group('lint')]
lint-vale-staged:
	@git diff --cached --name-only -z --diff-filter=ACMR -- '*.md' | xargs -0 -r vale --config=.vale.ini

install:
	@p="$(git rev-parse --git-path hooks)/pre-commit"; printf '%s\n' '#!/usr/bin/env bash' 'set -euo pipefail' '' 'cd "$(git rev-parse --show-toplevel)"' 'exec just pre-commit' > "$p"; chmod +x "$p"

pre-commit: lint-markdown-staged lint-vale-staged
