# Graph Report - mynixos.feat-46-upgrade-service  (2026-06-14)

## Corpus Check
- 18 files · ~4,819 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 151 nodes · 131 edges · 22 communities (17 shown, 5 thin omitted)
- Extraction: 99% EXTRACTED · 1% INFERRED · 0% AMBIGUOUS · INFERRED: 1 edges (avg confidence: 0.95)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `cfb4a830`
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
- [[_COMMUNITY_Community 18|Community 18]]
- [[_COMMUNITY_Community 19|Community 19]]
- [[_COMMUNITY_Community 21|Community 21]]

## God Nodes (most connected - your core abstractions)
1. `SNROS` - 12 edges
2. `VM Tests` - 8 edges
3. `Den Patterns` - 7 edges
4. `Upgrade Service` - 7 edges
5. `SNROS Domain Glossary` - 6 edges
6. `NixOS Helpers` - 6 edges
7. `SNROS` - 5 edges
8. `ADR 0001: devenv over flake-native dev shell` - 5 edges
9. `ADR 0002: Preservation over Impermanence` - 5 edges
10. `Domain Docs` - 5 edges

## Surprising Connections (you probably didn't know these)
- `prek pre-commit checker` --semantically_similar_to--> `prek Pre-commit Tool`  [INFERRED] [semantically similar]
  .github/workflows/check.yaml → CLAUDE.md

## Import Cycles
- None detected.

## Communities (22 total, 5 thin omitted)

### Community 0 - "Den Framework Core"
Cohesion: 0.18
Nodes (10): 1. Create the module file, 2. Add aspect tests, 3. Format and lint, 4. Write the reference page, 5. Run all checks, 6. Commit everything together, Add a New Module, Adding preservation (+2 more)

### Community 1 - "Dendritic Module System"
Cohesion: 0.18
Nodes (10): Applying a Host Configuration, Development, Getting Started, Hooks, License, Overview, Prerequisites, Setup (+2 more)

### Community 2 - "Project Tooling"
Cohesion: 0.11
Nodes (18): Agent skills, Architecture, Building, Conventions, den Framework, modules/dendritic.nix, Dendritic Pattern, Domain docs (+10 more)

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
Cohesion: 0.14
Nodes (13): Adding a new VM test, All checks (includes VM tests), CI considerations, Common test script commands, Current tests, How to run, Naming convention, References (+5 more)

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

### Community 18 - "Community 18"
Cohesion: 0.18
Nodes (10): Adding a new test, Adding host-specific tests, How to run, Local (on the machine itself), Python dependencies, Remote (SSH to a host), Specific test file, Test structure (+2 more)

### Community 21 - "Community 21"
Cohesion: 0.18
Nodes (10): Check last result, Den configuration, Failure behavior, How it works internally, How to use, No automatic polling, Trigger an upgrade, Upgrade Service (+2 more)

## Knowledge Gaps
- **94 isolated node(s):** `Description`, `Linked Issue`, `Checklist`, `Breaking Changes`, `Architecture` (+89 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **5 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `SNROS` connect `Project Tooling` to `Pre-commit Pipeline`?**
  _High betweenness centrality (0.022) - this node is a cross-community bridge._
- **Why does `prek Pre-commit Tool` connect `Pre-commit Pipeline` to `Project Tooling`?**
  _High betweenness centrality (0.009) - this node is a cross-community bridge._
- **What connects `Tests that should pass on any SNROS host.`, `Description`, `Linked Issue` to the rest of the system?**
  _95 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Project Tooling` be split into smaller, more focused modules?**
  _Cohesion score 0.1111111111111111 - nodes in this community are weakly interconnected._
- **Should `Community 11` be split into smaller, more focused modules?**
  _Cohesion score 0.14285714285714285 - nodes in this community are weakly interconnected._