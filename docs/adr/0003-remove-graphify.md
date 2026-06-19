# ADR 0003: Remove Graphify

## Status

Accepted

## Context

SNROS integrated [graphify](https://github.com/safishamsi/graphify) as a knowledge graph of the codebase — a JSON graph rebuilt automatically by post-commit and post-checkout git hooks, with tracked outputs in `graphify-out/`. The integration involved:

- A heavy Python dependency (`graphifyy` + ~25 tree-sitter parsers + networkx + numpy)
- 150+ lines of shell in git hooks (Python interpreter detection, background rebuild, detached process management)
- A two-commit workflow (code commit triggers rebuild, then manually commit graph outputs)
- A pre-push guard to block pushes with dirty `graphify-out/`
- A global prek exclude for the generated directory

The intended benefit was giving Claude Code richer codebase navigation via a persistent knowledge graph.

## Decision

Remove graphify entirely. The tool's value could not be measured — it was unclear whether it was working correctly, whether the graph was being consumed during sessions, or whether it provided any advantage over Claude Code's built-in Grep/Glob/Explore tools.

## Consequences

- Eliminates ~10,000 lines of tracked generated output and 150+ lines of hook complexity.
- Removes the two-commit workflow overhead from every development session.
- Drops a heavy Python dependency tree (networkx, numpy, 25 tree-sitter grammars).
- Codebase navigation relies entirely on Claude Code's built-in tools (Grep, Glob, Agent/Explore).
- If a future knowledge graph tool proves its value measurably, it can be re-added — but the bar is: demonstrate concrete benefit before committing to maintenance burden.
