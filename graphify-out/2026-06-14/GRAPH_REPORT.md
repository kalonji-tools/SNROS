# Graph Report - mynixos.feat-33-nix-helpers  (2026-06-13)

## Corpus Check
- 13 files · ~3,830 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 106 nodes · 91 edges · 18 communities (14 shown, 4 thin omitted)
- Extraction: 99% EXTRACTED · 1% INFERRED · 0% AMBIGUOUS · INFERRED: 1 edges (avg confidence: 0.95)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `b637abe9`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- [[_COMMUNITY_Den Framework Core|Den Framework Core]]
- [[_COMMUNITY_Dendritic Module System|Dendritic Module System]]
- [[_COMMUNITY_Project Tooling|Project Tooling]]
- [[_COMMUNITY_Pre-commit Pipeline|Pre-commit Pipeline]]
- [[_COMMUNITY_CI Infrastructure|CI Infrastructure]]
- [[_COMMUNITY_NixOS Defaults|NixOS Defaults]]
- [[_COMMUNITY_Dev Shell|Dev Shell]]
- [[_COMMUNITY_Host Declarations|Host Declarations]]
- [[_COMMUNITY_Community 8|Community 8]]
- [[_COMMUNITY_Community 9|Community 9]]
- [[_COMMUNITY_Community 10|Community 10]]
- [[_COMMUNITY_Community 11|Community 11]]
- [[_COMMUNITY_Community 12|Community 12]]
- [[_COMMUNITY_Community 13|Community 13]]
- [[_COMMUNITY_Community 14|Community 14]]
- [[_COMMUNITY_Community 15|Community 15]]
- [[_COMMUNITY_Community 16|Community 16]]
- [[_COMMUNITY_Community 17|Community 17]]

## God Nodes (most connected - your core abstractions)
1. `SNROS` - 12 edges
2. `Den Patterns` - 7 edges
3. `SNROS Domain Glossary` - 6 edges
4. `NixOS Helpers` - 6 edges
5. `SNROS` - 5 edges
6. `ADR 0001: devenv over flake-native dev shell` - 5 edges
7. `ADR 0002: Preservation over Impermanence` - 5 edges
8. `Domain Docs` - 5 edges
9. `Add a New Module` - 5 edges
10. `Agent skills` - 4 edges

## Surprising Connections (you probably didn't know these)
- `prek pre-commit checker` --semantically_similar_to--> `prek Pre-commit Tool`  [INFERRED] [semantically similar]
  .github/workflows/check.yaml → CLAUDE.md

## Import Cycles
- None detected.

## Communities (18 total, 4 thin omitted)

### Community 0 - "Den Framework Core"
Cohesion: 0.18
Nodes (10): 1. Create the module file, 2. Add aspect tests, 3. Format and lint, 4. Write the reference page, 5. Run all checks, 6. Commit everything together, Add a New Module, Adding preservation (+2 more)

### Community 1 - "Dendritic Module System"
Cohesion: 0.18
Nodes (10): Applying a Host Configuration, Development, Getting Started, Hooks, License, Overview, Prerequisites, Setup (+2 more)

### Community 2 - "Project Tooling"
Cohesion: 0.14
Nodes (14): Architecture, Building, Conventions, den Framework, modules/dendritic.nix, Dendritic Pattern, flake-file, flake-parts (+6 more)

### Community 3 - "Pre-commit Pipeline"
Cohesion: 0.33
Nodes (6): prek Pre-commit Tool, Check Workflow, Determinate Systems Magic Nix Cache, nix develop, Determinate Systems Nix Installer, prek pre-commit checker

### Community 4 - "CI Infrastructure"
Cohesion: 0.33
Nodes (5): ADR 0001: devenv over flake-native dev shell, Consequences, Context, Decision, Status

### Community 8 - "Community 8"
Cohesion: 0.33
Nodes (5): Before exploring, read these, Domain Docs, File structure, Flag ADR conflicts, Use the glossary's vocabulary

### Community 9 - "Community 9"
Cohesion: 0.40
Nodes (4): Conventions, Issue tracker: GitHub, When a skill says "fetch the relevant ticket", When a skill says "publish to the issue tracker"

### Community 10 - "Community 10"
Cohesion: 0.40
Nodes (4): Breaking Changes, Checklist, Description, Linked Issue

### Community 11 - "Community 11"
Cohesion: 0.50
Nodes (4): Agent skills, Domain docs, Issue tracker, Triage labels

### Community 13 - "Community 13"
Cohesion: 0.25
Nodes (7): Aspect Tests, Aspects, Composition, Den Patterns, Key Concepts, Module Files, Standalone Evaluation with `den.homes`

### Community 14 - "Community 14"
Cohesion: 0.29
Nodes (6): Shell, SNROS Domain Glossary, System-Defining Layer, Terminal, Theming, Tool Categories

### Community 15 - "Community 15"
Cohesion: 0.33
Nodes (5): ADR 0002: Preservation over Impermanence, Consequences, Context, Decision, Status

### Community 16 - "Community 16"
Cohesion: 0.50
Nodes (3): Documentation, Project Links, SNROS

### Community 17 - "Community 17"
Cohesion: 0.29
Nodes (6): Den configuration, NixOS Helpers, Post-deploy verification, Preservation, Standalone evaluation, What it does

## Knowledge Gaps
- **69 isolated node(s):** `Description`, `Linked Issue`, `Checklist`, `Breaking Changes`, `Architecture` (+64 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **4 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `SNROS` connect `Project Tooling` to `Pre-commit Pipeline`, `Community 11`?**
  _High betweenness centrality (0.045) - this node is a cross-community bridge._
- **Why does `prek Pre-commit Tool` connect `Pre-commit Pipeline` to `Project Tooling`?**
  _High betweenness centrality (0.017) - this node is a cross-community bridge._
- **What connects `Description`, `Linked Issue`, `Checklist` to the rest of the system?**
  _69 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Project Tooling` be split into smaller, more focused modules?**
  _Cohesion score 0.14285714285714285 - nodes in this community are weakly interconnected._