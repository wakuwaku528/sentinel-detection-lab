# Microsoft Sentinel Cloud SOC & Detection Engineering Lab

A hands-on Microsoft Azure security operations lab built to practise the end-to-end detection lifecycle using Microsoft Sentinel, Microsoft Defender, Windows security telemetry, Active Directory, and Microsoft Entra ID.

The project progresses from building the underlying identity and telemetry environment to simulating attacks, developing KQL detections, generating incidents, performing analyst triage, and tuning detection logic based on observed results.

> **Project scope:** This is an independently built cybersecurity lab using controlled attack simulations and lab-generated telemetry. It does not represent commercial or production SOC employment.

---

## Project Overview

The goal of this project is to demonstrate practical security operations and detection engineering workflows rather than isolated KQL queries.

The environment was developed progressively across three phases:

1. Build the target infrastructure and identity environment.
2. Configure security auditing and telemetry collection.
3. Establish baseline activity.
4. Simulate adversary behaviour.
5. Analyse the resulting telemetry.
6. Develop custom KQL detections.
7. Generate and investigate Sentinel incidents.
8. Tune detection logic based on testing and investigation results.

### Detection Lifecycle

```text
Target Environment
        ↓
Telemetry Generation
        ↓
Telemetry Collection
        ↓
Baseline Analysis
        ↓
Attack Simulation
        ↓
KQL Detection Engineering
        ↓
Sentinel Analytics Rule
        ↓
Alert & Incident Generation
        ↓
Microsoft Defender Triage
        ↓
Detection Tuning
```

---

## Project Phases

### Phase 1: Target Environment & Identity Architecture

Built the Azure-hosted Active Directory environment that provides the identities, systems, and security telemetry used throughout the detection lab.

Key work included:

- Deployed Active Directory Domain Services for the `lab.local` domain.
- Created the `Corp-HQ` organisational structure with administrative, departmental, and test identities.
- Automated Active Directory user provisioning using PowerShell.
- Configured security groups and role-based access boundaries within the lab.
- Enabled advanced Windows auditing for authentication activity.
- Validated successful and failed authentication telemetry in Windows Security Events.
- Prepared the environment for subsequent adversary simulations and Sentinel detection engineering.

This phase established the infrastructure and telemetry foundation used by the later attack modules.

---

### Module 01: Horizontal Password Spraying

[View Module 01](./attacks/01-password-spray/)

Simulated a horizontal password spraying attack against multiple Active Directory accounts and developed a Microsoft Sentinel detection workflow around the resulting authentication telemetry.

The module covers:

- Windows authentication telemetry
- Azure Monitor Agent (AMA)
- Data Collection Rules (DCR)
- Azure Log Analytics
- Authentication baseline analysis
- PowerShell attack simulation
- KQL detection engineering
- Microsoft Sentinel analytics rules
- Detection tuning
- Alert and incident generation
- Microsoft Defender incident triage

During validation, overlapping brute-force and password-spray detection logic was identified and refined to distinguish high-volume attacks against an individual account from password spraying across multiple accounts.

**MITRE ATT&CK:** `T1110.003` — Brute Force: Password Spraying

---

### Module 02: Suspicious MFA Registration & Persistence

[View Module 02](./attacks/02-mfa-persistence/)

Extended the SOC environment into Microsoft Entra ID to investigate identity persistence through suspicious MFA security information changes.

The module covers:

- Microsoft Entra ID telemetry
- `AuditLogs` and sign-in context
- Rogue MFA registration simulation
- KQL identity detection engineering
- Microsoft Sentinel analytics rules
- Account and IP entity mapping
- Alert enrichment
- Incident generation
- Alert grouping and tuning
- Identity-focused analyst triage
- Containment workflow development

Testing demonstrated that a single MFA registration workflow can generate multiple related Entra ID audit events. The detection was tuned based on the observed telemetry so related alerts could be correlated into a more actionable incident.

**MITRE ATT&CK:** `T1098.005`

---

## Detection Scenarios

| Module | Scenario | Primary Data Source | Detection Focus | MITRE ATT&CK |
|---|---|---|---|---|
| 01 | Horizontal Password Spraying | Windows Security Events | Authentication failures distributed across multiple accounts | `T1110.003` |
| 02 | Suspicious MFA Registration | Microsoft Entra ID AuditLogs | Authentication method registration and modification | `T1098.005` |

---

## SOC Technologies

### SIEM & Detection

- Microsoft Sentinel
- Azure Log Analytics
- Kusto Query Language (KQL)
- Microsoft Sentinel Analytics Rules
- Entity Mapping
- Alert Grouping
- Detection Tuning

### Telemetry

- Windows Security Events
- Microsoft Entra ID AuditLogs
- Microsoft Entra ID SigninLogs
- Azure Monitor Agent (AMA)
- Data Collection Rules (DCR)

### Identity & Infrastructure

- Microsoft Azure
- Active Directory Domain Services
- Microsoft Entra ID
- Windows Server
- Group Policy
- Azure Virtual Machines

### Investigation & Response

- Microsoft Defender
- Alert Triage
- Incident Investigation
- Authentication Analysis
- Identity Threat Analysis
- Detection Validation
- MITRE ATT&CK

### Scripting

- PowerShell
- KQL

---

## Repository Structure

```text
sentinel-detection-lab/
│
├── attacks/
│   │
│   ├── 01-password-spray/
│   │   ├── README.md
│   │   ├── KQL detection artefacts
│   │   └── evidence/
│   │
│   └── 02-mfa-persistence/
│       ├── README.md
│       ├── KQL detection artefacts
│       └── evidence/
│
├── detections/
│   └── KQL/
│       └── Foundation detection artefacts
│
├── scripts/
│   └── simulation-scripts.ps1
│
└── README.md
```

Each attack module is structured as a self-contained SOC scenario containing the relevant detection logic, supporting evidence, and investigation documentation.

---

## Skills Demonstrated

This project provides hands-on technical evidence across the security detection lifecycle:

- Microsoft Sentinel SIEM configuration and investigation
- Azure security telemetry ingestion
- Windows authentication log analysis
- Microsoft Entra ID audit log analysis
- KQL query development
- Custom Sentinel analytics rule development
- Detection threshold design
- Detection tuning
- Alert grouping
- Entity mapping and enrichment
- Incident generation and triage
- Authentication attack investigation
- Identity persistence investigation
- Active Directory configuration
- PowerShell scripting
- Controlled adversary simulation
- MITRE ATT&CK mapping

---

## Detailed Technical Write-Ups

The project is also documented as a three-part technical series on Medium.

### Phase 1 — Target Environment & Identity Architecture

Active Directory infrastructure, identity provisioning, security groups, advanced audit policy, authentication telemetry, and initial detection preparation.

[Read Phase 1 on Medium](https://medium.com/@ianchow528/building-an-enterprise-lab-from-scratch-phase-1-active-directory-automation-and-iam-c592d3a521a3)

### Phase 2 — Horizontal Password Spraying & Credential Access Detection

AMA and DCR telemetry ingestion, authentication baselining, password spray simulation, KQL detection engineering, rule tuning, and Defender incident triage.

[Read Phase 2 on Medium](https://medium.com/@ianchow528/building-an-automated-cloud-soc-detection-pipeline-phase-2-automated-telemetry-event-0a8ef1b080af)

### Phase 3 — Suspicious MFA Registration & Persistence Detection

Microsoft Entra ID telemetry, rogue MFA registration simulation, custom KQL detection, entity mapping, alert grouping, incident tuning, and identity-focused triage.

[Read Phase 3 on Medium](https://medium.com/@ianchow528/building-an-automated-cloud-soc-detection-pipeline-phase-3-suspicious-mfa-registration-cc22fd496fd8)

---

## Project Scope & Disclaimer

This repository documents an independently built cybersecurity lab created for hands-on security operations, detection engineering, and incident investigation practice.

All attacks were executed in controlled test environments against lab-created identities and infrastructure.

The telemetry, alerts, incidents, detection rules, screenshots, and investigation workflows shown in this repository were produced as part of the lab and should not be interpreted as commercial production SOC experience.
