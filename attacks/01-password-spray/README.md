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

[`password-spray-script.ps1`](./password-spray-script.ps1)

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
```

The Data Collection Rule captured authentication activity including:

- `Event ID 4624` — Successful Logon
- `Event ID 4625` — Authentication Failure

Before running the attack simulation, normal authentication activity was queried in Log Analytics to verify ingestion and establish a baseline.

---

## Detection Logic

A custom Microsoft Sentinel analytics rule was developed to identify horizontal password spraying by analysing failed authentication activity across multiple accounts from the same source.

The detection evaluates:

- Total authentication failures
- Number of unique targeted accounts
- Source IP address
- Source workstation

Detection threshold:

```text
TargetedAccountsCount >= 3
AND
TotalFailures >= 5
```

The KQL query analyses authentication failures over a **1-hour lookback period**, while the Microsoft Sentinel analytics rule executes **every 5 minutes**.

The KQL detection query used for this scenario is stored within this module.

### MITRE ATT&CK

**T1110.003 — Brute Force: Password Spraying**

---

## Detection Tuning

During validation, an existing volume-based brute-force detection also identified the simulated activity.

The original rule focused on authentication failure volume from a source, while the new password spraying rule was designed to identify account diversity from the same source.

To distinguish the two attack patterns, the legacy brute-force detection was refined to aggregate authentication failures by:

```text
IpAddress + TargetUserName
```

This allowed the detections to distinguish between:

- **Vertical brute force:** repeated authentication failures against an individual account
- **Horizontal password spraying:** authentication failures distributed across multiple accounts

The result was separate detection coverage for both behaviours while reducing overlapping incident generation.

---

## Incident Validation

After tuning the detection logic, the attack simulation was executed again.

Microsoft Sentinel generated the expected incident and surfaced it in the Microsoft Defender portal for analyst triage.

The incident provided investigation context including:

- Source IP address
- Source workstation
- Affected system
- Authentication activity
- Detection query results

---

## Analyst Triage

Initial investigation of the password spraying alert included:

1. Review the identities targeted by the authentication failures.
2. Determine whether privileged or sensitive accounts were included.
3. Validate whether the source IP address and workstation were expected within the environment.
4. Review the authentication failure activity associated with the source.
5. Search for subsequent `Event ID 4624` successful logons from the same source.
6. Determine whether any password attempt resulted in successful authentication.

---

## Detection Lifecycle

```text
Attack Simulation
        ↓
Windows Authentication Events
        ↓
AMA / DCR Ingestion
        ↓
Azure Log Analytics
        ↓
KQL Detection
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

## Evidence

Evidence collected during the scenario includes:

- Attack simulation output
- Windows authentication event ingestion
- KQL query results
- Microsoft Sentinel analytics rule configuration
- Generated Sentinel incident
- Microsoft Defender incident triage
- Detection tuning validation

See the [`evidence/`](./evidence/) directory for screenshots captured during the lab.

---

## Skills Demonstrated

- Microsoft Sentinel
- Azure Log Analytics
- Kusto Query Language (KQL)
- Azure Monitor Agent (AMA)
- Data Collection Rules (DCR)
- Windows Security Event analysis
- Active Directory
- PowerShell
- Detection engineering
- Detection tuning
- Alert triage
- Authentication attack analysis
- MITRE ATT&CK
