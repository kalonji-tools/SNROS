# Graph Report - .  (2026-06-12)

## Corpus Check
- Corpus is ~324 words - fits in a single context window. You may not need a graph.

## Summary
- 18 nodes · 15 edges · 8 communities (5 shown, 3 thin omitted)
- Extraction: 93% EXTRACTED · 7% INFERRED · 0% AMBIGUOUS · INFERRED: 1 edges (avg confidence: 0.95)
- Token cost: 0 input · 0 output

## Community Hubs (Navigation)
- [[_COMMUNITY_Den Framework Core|Den Framework Core]]
- [[_COMMUNITY_Dendritic Module System|Dendritic Module System]]
- [[_COMMUNITY_Project Tooling|Project Tooling]]
- [[_COMMUNITY_Pre-commit Pipeline|Pre-commit Pipeline]]
- [[_COMMUNITY_CI Infrastructure|CI Infrastructure]]
- [[_COMMUNITY_NixOS Defaults|NixOS Defaults]]
- [[_COMMUNITY_Dev Shell|Dev Shell]]
- [[_COMMUNITY_Host Declarations|Host Declarations]]

## God Nodes (most connected - your core abstractions)
1. `SNROS NixOS Configuration` - 5 edges
2. `Dendritic Pattern` - 4 edges
3. `Check Workflow` - 3 edges
4. `nix develop` - 2 edges
5. `prek pre-commit checker` - 2 edges
6. `den Framework` - 2 edges
7. `prek Pre-commit Tool` - 2 edges
8. `flake-file` - 2 edges
9. `modules/dendritic.nix` - 2 edges
10. `Determinate Systems Nix Installer` - 1 edges

## Surprising Connections (you probably didn't know these)
- `prek pre-commit checker` --semantically_similar_to--> `prek Pre-commit Tool`  [INFERRED] [semantically similar]
  .github/workflows/check.yaml → CLAUDE.md

## Import Cycles
- None detected.

## Communities (8 total, 3 thin omitted)

### Community 0 - "Den Framework Core"
Cohesion: 0.67
Nodes (3): den Framework, modules/dendritic.nix, flake-file

### Community 1 - "Dendritic Module System"
Cohesion: 0.67
Nodes (3): Dendritic Pattern, flake-parts, import-tree

### Community 2 - "Project Tooling"
Cohesion: 0.67
Nodes (3): graphify-out Knowledge Graph, nixfmt Formatter, SNROS NixOS Configuration

### Community 3 - "Pre-commit Pipeline"
Cohesion: 0.67
Nodes (3): prek Pre-commit Tool, nix develop, prek pre-commit checker

### Community 4 - "CI Infrastructure"
Cohesion: 0.67
Nodes (3): Check Workflow, Determinate Systems Magic Nix Cache, Determinate Systems Nix Installer

## Knowledge Gaps
- **9 isolated node(s):** `Determinate Systems Nix Installer`, `Determinate Systems Magic Nix Cache`, `flake-parts`, `import-tree`, `nixfmt Formatter` (+4 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **3 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `SNROS NixOS Configuration` connect `Project Tooling` to `Den Framework Core`, `Dendritic Module System`, `Pre-commit Pipeline`?**
  _High betweenness centrality (0.471) - this node is a cross-community bridge._
- **Why does `prek Pre-commit Tool` connect `Pre-commit Pipeline` to `Project Tooling`?**
  _High betweenness centrality (0.331) - this node is a cross-community bridge._
- **What connects `Determinate Systems Nix Installer`, `Determinate Systems Magic Nix Cache`, `flake-parts` to the rest of the system?**
  _9 weakly-connected nodes found - possible documentation gaps or missing edges._
