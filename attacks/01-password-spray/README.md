# Module 01: Horizontal Password Spraying

## Overview

This module covers the simulation, telemetry ingestion, KQL detection engineering, rule tuning, and incident triage of a horizontal password spraying attack against an Active Directory environment.

- **MITRE ATT&CK Mapping:** Credential Access — Brute Force: Password Spray (`T1110.003`)
- **Data Sources:** Windows Security Events (`Event ID 4625`, `Event ID 4624`) via Azure Monitor Agent (AMA)
- **Target Accounts:** `bwayne`, `jsmith`, `sconnor`, `jdoe`, `labadmin`

---

## Execution Script

The attack simulation cycles three test passwords across five domain accounts to reproduce horizontal password spraying behaviour.

The PowerShell execution logic is located in:

[`../../scripts/simulation-scripts.ps1`](../../scripts/simulation-scripts.ps1)

The simulation generated **15 failed authentication events across 5 target accounts**, which were collected from the domain controller and ingested into Microsoft Sentinel through the AMA telemetry pipeline.

---

## Telemetry Pipeline

Authentication telemetry was collected from the Active Directory domain controller using:

```text
Windows Security Events
        ↓
Azure Monitor Agent (AMA)
        ↓
Data Collection Rule (DCR)
        ↓
Azure Log Analytics
        ↓
Microsoft Sentinel
