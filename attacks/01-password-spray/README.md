# Module 01: Horizontal Password Spraying

## Overview
This module covers the simulation, telemetry ingestion, KQL detection authoring, and alert triage for a horizontal password spray attack against an active directory environment.

* **MITRE ATT&CK Mapping:** Credential Access — Brute Force: Password Spray (`T1110.003`)
* **Data Sources:** Windows Security Events (`Event ID 4625`, `Event ID 4624`) via Azure Monitor Agent (AMA).
* **Target Accounts:** `bwayne`, `jsmith`, `sconnor`, `jdoe`, `labadmin`.

---

## Execution Script
The attack simulation cycles common seasonal passwords across multiple domain accounts to evade single-account lockout thresholds. The PowerShell execution logic is located in [`../../scripts/simulation-scripts.ps1`](../../scripts/simulation-scripts.ps1).