# Microsoft Sentinel Cloud SOC & Detection Engineering Lab

A hands-on Microsoft Azure security operations project demonstrating the end-to-end detection lifecycle across Active Directory, Microsoft Sentinel, Microsoft Defender, and Microsoft Entra ID.

The project progresses from building the underlying identity and telemetry environment to simulating adversary activity, developing KQL detections, generating incidents, performing analyst triage, and tuning detections based on observed telemetry.

> **Project Scope:** This is an independently built cybersecurity lab using controlled attack simulations and lab-generated telemetry. It does not represent commercial or production SOC employment.

---

## Project Overview

This repository demonstrates practical SOC and detection engineering workflows rather than isolated KQL exercises.

The project follows a progressive structure:

```text
Foundation
Active Directory + Security Auditing + Detection Validation
        ↓
Module 01
Horizontal Password Spraying
        ↓
Module 02
Suspicious MFA Registration & Persistence
```

Across the project, the detection lifecycle includes:

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

## Foundation: Target Environment, Identity & Detection Validation

[View Foundation](./foundation/)

The foundation establishes the Azure-hosted Windows and Active Directory environment used by the later detection modules.

Key work included:

- Deployed Active Directory Domain Services for the `lab.local` domain.
- Created the `Corp-HQ` organisational structure with administrative, departmental, and test identities.
- Automated Active Directory user provisioning using PowerShell.
- Configured departmental security groups and access boundaries.
- Enabled advanced Windows auditing for authentication activity.
- Validated successful and failed authentication telemetry using Windows Security Events.
- Generated controlled brute-force authentication activity.
- Developed an initial KQL detection to validate that the environment could generate usable security telemetry for SOC analysis.

### Technical Artefacts

- [`BruteForce_Detection.kql`](./foundation/BruteForce_Detection.kql)
- [`Simulate-BruteForce.ps1`](./foundation/Simulate-BruteForce.ps1)

---

## Module 01: Horizontal Password Spraying

[View Module 01](./attacks/01-password-spray/)

This module extends the foundation into a Microsoft Sentinel detection workflow for horizontal password spraying.

A controlled PowerShell simulation cycled three test passwords across five Active Directory accounts, generating failed authentication activity for ingestion and analysis.

The module covers:

- Windows authentication telemetry
- Azure Monitor Agent (AMA)
- Data Collection Rules (DCR)
- Azure Log Analytics
- Authentication baseline analysis
- PowerShell attack simulation
- KQL detection engineering
- Microsoft Sentinel analytics rules
- Detection threshold logic
- Detection tuning
- Alert and incident generation
- Microsoft Defender incident triage

During validation, overlapping brute-force and password-spray detection logic was identified.

The legacy brute-force detection was refined to distinguish repeated attacks against an individual account from horizontal password spraying across multiple accounts, reducing overlapping incident generation while preserving both detection scenarios.

**MITRE ATT&CK:** `T1110.003` — Brute Force: Password Spraying

### Technical Artefacts

- [`detection.kql`](./attacks/01-password-spray/detection.kql)
- [`password-spray-script.ps1`](./attacks/01-password-spray/password-spray-script.ps1)
- [`tuning-notes.md`](./attacks/01-password-spray/tuning-notes.md)
- [`evidence/`](./attacks/01-password-spray/evidence/)

---

## Module 02: Suspicious MFA Registration & Persistence

[View Module 02](./attacks/02-mfa-persistence/)

This module extends the SOC environment into Microsoft Entra ID identity threat detection.

The scenario simulates an attacker operating with valid credentials and registering an additional authentication method to establish persistence.

The module covers:

- Microsoft Entra ID `AuditLogs`
- Microsoft Entra ID `SigninLogs`
- Rogue MFA registration simulation
- KQL identity detection engineering
- Microsoft Sentinel analytics rules
- Account and IP entity mapping
- Alert enrichment
- Incident generation
- Alert grouping
- Detection tuning
- Identity-focused incident triage
- Identity containment workflow development

Testing showed that a single MFA registration workflow generated multiple related Entra ID audit events.

The initial alert grouping configuration caused related activity to be separated into multiple incidents. The underlying telemetry was investigated, grouping logic was refined around the affected Account entity, and the scenario was retested.

The revised configuration successfully consolidated related alerts into a more actionable Sentinel incident.

**MITRE ATT&CK:** `T1098.005`

### Technical Artefacts

- [`detection.kql`](./attacks/02-mfa-persistence/detection.kql)
- [`tuning-notes.md`](./attacks/02-mfa-persistence/tuning-notes.md)
- [`evidence/`](./attacks/02-mfa-persistence/evidence/)

---

## Detection Scenarios

| Stage | Scenario | Primary Data Source | Detection Focus | MITRE ATT&CK |
|---|---|---|---|---|
| Foundation | Brute-Force Validation | Windows Security Events | Repeated authentication failures | Detection validation |
| Module 01 | Horizontal Password Spraying | Windows Security Events | Failed authentication across multiple accounts | `T1110.003` |
| Module 02 | Suspicious MFA Registration | Microsoft Entra ID AuditLogs | Authentication method registration and modification | `T1098.005` |

---

## SOC Technologies

### SIEM & Detection

- Microsoft Sentinel
- Azure Log Analytics
- Kusto Query Language (KQL)
- Microsoft Sentinel Analytics Rules
- Detection Threshold Development
- Detection Tuning
- Alert Grouping
- Entity Mapping
- Alert Enrichment

### Security Telemetry

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
- Identity Containment Planning
- MITRE ATT&CK

### Scripting & Querying

- PowerShell
- KQL

---

## Repository Structure

```text
sentinel-detection-lab/
│
├── foundation/
│   ├── README.md
│   ├── BruteForce_Detection.kql
│   └── Simulate-BruteForce.ps1
│
├── attacks/
│   │
│   ├── 01-password-spray/
│   │   ├── README.md
│   │   ├── detection.kql
│   │   ├── password-spray-script.ps1
│   │   ├── tuning-notes.md
│   │   └── evidence/
│   │
│   └── 02-mfa-persistence/
│       ├── README.md
│       ├── detection.kql
│       ├── tuning-notes.md
│       └── evidence/
│
├── .gitignore
└── README.md
```

The repository is organised so that each stage documents a progressively more complete security operations workflow.

The **Foundation** establishes the infrastructure and telemetry required for detection.

Each subsequent **attack module** contains the detection logic, technical notes, investigation workflow, and supporting evidence associated with that scenario.

---

## Skills Demonstrated

This project provides hands-on technical evidence across the security detection lifecycle:

- Microsoft Sentinel SIEM investigation
- Azure security telemetry ingestion
- Windows authentication log analysis
- Microsoft Entra ID audit log analysis
- KQL query development
- Custom Sentinel analytics rule development
- Detection threshold development
- Detection tuning
- Alert grouping
- Entity mapping and enrichment
- Incident generation and triage
- Authentication attack investigation
- Identity persistence investigation
- Active Directory configuration
- Windows security auditing
- PowerShell scripting
- Controlled adversary simulation
- MITRE ATT&CK mapping

---

## Technical Write-Ups

The project is documented in a three-part technical series on Medium.

### Phase 1 — Target Environment & Identity Architecture

Active Directory infrastructure, automated identity provisioning, security groups, Windows audit policy, authentication telemetry, brute-force simulation, and initial detection validation.

[Read Phase 1 on Medium](https://medium.com/@ianchow528/building-an-enterprise-lab-from-scratch-phase-1-active-directory-automation-and-iam-c592d3a521a3)

### Phase 2 — Horizontal Password Spraying & Credential Access Detection

AMA and DCR telemetry ingestion, authentication baselining, password spray simulation, KQL detection engineering, rule tuning, and Microsoft Defender incident triage.

[Read Phase 2 on Medium](https://medium.com/@ianchow528/building-an-automated-cloud-soc-detection-pipeline-phase-2-automated-telemetry-event-0a8ef1b080af)

### Phase 3 — Suspicious MFA Registration & Persistence Detection

Microsoft Entra ID telemetry, rogue MFA registration simulation, custom KQL detection, entity mapping, alert grouping, incident tuning, and identity-focused triage.

[Read Phase 3 on Medium](https://medium.com/@ianchow528/building-an-automated-cloud-soc-detection-pipeline-phase-3-suspicious-mfa-registration-cc22fd496fd8)

---

## Project Scope & Disclaimer

This repository documents an independently built cybersecurity lab created for hands-on security operations, detection engineering, and incident investigation practice.

All attacks were executed in controlled test environments against lab-created identities and infrastructure.

The telemetry, alerts, incidents, detection rules, screenshots, scripts, and investigation workflows shown in this repository were produced as part of the lab and should not be interpreted as commercial production SOC experience.
