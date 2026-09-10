# Foundation: Target Environment, Identity & Detection Validation

## Overview

This phase establishes the Windows and Active Directory environment used by the later Microsoft Sentinel attack modules.

The goal was to build the underlying identity infrastructure, configure security auditing, generate authentication telemetry, and validate that the environment could support detection engineering before progressing to more advanced attack scenarios.

> **Environment:** Independent cybersecurity lab using controlled test identities, simulated authentication activity, and lab-generated telemetry.

---

## Environment Architecture

The lab was built around an Azure-hosted Windows Server environment running Active Directory Domain Services for the `lab.local` domain.

The directory structure included:

```text
lab.local
└── Corp-HQ
    ├── Admin Accounts
    ├── Groups
    └── Departments
        ├── HR
        ├── IT
        └── Sales
```

This structure provided multiple user identities and security-group boundaries for generating and analysing authentication activity during later attack simulations.

---

## Identity Provisioning

User accounts were provisioned using PowerShell to create a repeatable Active Directory test environment.

The provisioning workflow included:

- Standardised account naming
- User Principal Name configuration
- Department assignment
- Organisational Unit placement
- Initial password configuration
- Forced password change at first logon
- Account enablement

Directory attributes were validated using Active Directory PowerShell commands after provisioning.

---

## Access Structure

Departmental security groups were created to organise users according to their assigned roles.

The lab included separate groups for:

- IT
- HR
- Sales

This provided a structured identity environment for subsequent authentication monitoring and attack simulations.

---

## Security Audit Configuration

Advanced Windows auditing was configured through Group Policy to capture authentication-related security events.

Relevant audit categories included:

- Logon success and failure
- Account logon activity
- Credential validation activity

The objective was to ensure that authentication activity generated within the lab produced usable security telemetry for investigation and detection engineering.

---

## Telemetry Validation

A controlled authentication failure was generated against the lab environment to validate the audit configuration.

The failed authentication attempt produced:

```text
Event ID 4625
```

in the Windows Security Event Log.

This confirmed that the environment was successfully capturing the authentication telemetry required for later SOC detection workflows.

---

## Brute-Force Detection Validation

After confirming telemetry collection, a controlled brute-force simulation was used to generate repeated failed authentication activity.

The PowerShell simulation generated test authentication failures against the lab environment.

The resulting events were analysed using a custom KQL detection designed to identify rapid authentication failures and surface the activity for SOC triage.

---

## Detection Workflow

```text
Active Directory Environment
        ↓
Windows Advanced Auditing
        ↓
Authentication Activity
        ↓
Windows Security Events
        ↓
Controlled Brute-Force Simulation
        ↓
KQL Detection
        ↓
SOC Detection Validation
```

This initial workflow validated that the target environment could generate security telemetry suitable for later Microsoft Sentinel detection engineering.

---

## Technical Artefacts

| Artefact | Description |
|---|---|
| [`BruteForce_Detection.kql`](./BruteForce_Detection.kql) | KQL detection logic used to identify repeated failed authentication activity |
| [`Simulate-BruteForce.ps1`](./Simulate-BruteForce.ps1) | PowerShell script used to generate controlled brute-force authentication telemetry in the lab |

---

## Role in the Overall Project

This foundation phase provides the infrastructure and telemetry base for the later attack modules.

```text
Foundation
Active Directory + Audit Telemetry + Detection Validation
        ↓
Module 01
Horizontal Password Spraying
        ↓
Module 02
Suspicious MFA Registration & Persistence
```

The later modules extend this environment into more complete Microsoft Sentinel workflows involving telemetry ingestion, custom analytics rules, alert generation, incident triage, and detection tuning.

---

## Skills Demonstrated

- Active Directory Domain Services
- Windows Server
- Microsoft Azure
- PowerShell
- Active Directory user provisioning
- Organisational Unit configuration
- Security group configuration
- Group Policy
- Windows Advanced Audit Policy
- Windows Security Event analysis
- Authentication telemetry validation
- Kusto Query Language (KQL)
- Controlled attack simulation
- Detection engineering fundamentals
