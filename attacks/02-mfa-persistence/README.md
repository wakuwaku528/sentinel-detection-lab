# Module 02: Suspicious MFA Registration & Persistence Detection

## Overview

This module covers the simulation, telemetry analysis, KQL detection engineering, alert generation, rule tuning, and incident triage of suspicious MFA security information changes in Microsoft Entra ID.

The scenario represents an attacker who has obtained valid user credentials and attempts to establish persistence by registering an attacker-controlled authentication method.

- **MITRE ATT&CK Mapping:** `T1098.005`
- **Primary Data Source:** Microsoft Entra ID `AuditLogs`
- **Supporting Telemetry:** Microsoft Entra ID `SigninLogs`
- **SIEM:** Microsoft Sentinel
- **Investigation Platform:** Microsoft Defender

---

## Attack Scenario

A dedicated cloud test account was used to simulate an attacker operating with valid compromised credentials.

The simulated workflow involved:

1. Authenticating through an isolated browser session.
2. Accessing the Microsoft Security Info portal.
3. Registering an additional Microsoft Authenticator method.
4. Generating Entra ID audit telemetry associated with the security information change.

The objective was to test whether Microsoft Sentinel could detect identity persistence activity based on changes to authentication methods.

---

## Telemetry Pipeline

Microsoft Entra ID was integrated with Microsoft Sentinel to provide identity-focused security telemetry.

```text
Microsoft Entra ID
        ↓
AuditLogs / SigninLogs
        ↓
Azure Log Analytics
        ↓
Microsoft Sentinel
        ↓
KQL Detection
        ↓
Alert & Incident Generation
```

The Microsoft Entra ID connector provided the raw directory audit data required for custom detection engineering.

Relevant audit activity included security information registration and authentication method changes.

---

## Telemetry Analysis

After executing the MFA registration simulation, the resulting events were analysed in Microsoft Sentinel using KQL.

A single MFA registration workflow produced multiple related Entra ID audit events, including:

- `User registered security info`
- `User registered all required security info`
- `User changed default authentication method`

This demonstrated that a single user action can generate several related audit records.

The observation became important during later alert tuning because detecting every related event independently could create duplicate incidents.

---

## Detection Engineering

A custom Microsoft Sentinel scheduled analytics rule was developed to detect security information registration and authentication method changes.

The KQL detection monitors the relevant Entra ID operations and extracts investigation context including:

- Target user
- Initiating account
- Initiating IP address
- Operation name
- Result
- Result details

The analytics rule is configured with:

- **Query frequency:** Every 5 minutes
- **Lookback period:** 1 hour
- **Trigger threshold:** More than 0 matching results
- **Incident creation:** Enabled

The KQL detection query used for this scenario is stored within this module.

---

## Entity Mapping & Alert Enrichment

Detection output was mapped into Microsoft Sentinel entities to provide useful investigation context directly within generated alerts and incidents.

Mapped information included:

- **Target Account:** Identity affected by the authentication method change
- **Initiating Account:** Identity responsible for performing the change
- **Source IP:** IP address associated with the action

Custom alert details also surfaced:

- `OperationName`
- `Result`
- `ResultDetails`

This allowed relevant context to be visible during initial analyst triage without relying only on additional ad hoc queries.

---

## Incident Generation

The initial attack simulation successfully triggered the custom analytics rule and generated incidents in Microsoft Sentinel.

During testing, a single MFA registration sequence produced multiple related alerts because Microsoft Entra ID recorded more than one audit event for the same registration workflow.

The initial grouping configuration required matching across multiple entities, causing related events with slightly different telemetry to be separated into different incidents.

---

## Detection Tuning

The duplicate incident behaviour was investigated using the underlying Entra ID telemetry.

The alert grouping configuration was then refined to group related activity based primarily on the affected **Account entity** over a **5-hour grouping window**.

After changing the grouping logic, the MFA registration simulation was executed again.

The subsequent test successfully consolidated multiple related alerts for the same account into a single incident.

This demonstrated an important detection engineering principle:

> Detection logic must account for how the underlying telemetry is actually generated, not only how the expected user action appears conceptually.

---

## Analyst Triage

Initial investigation of a suspicious MFA registration alert includes:

1. Review the target account and initiating identity.
2. Validate the source IP address against the user's recent sign-in history.
3. Identify unusual geographical or network activity.
4. Correlate the event with recent suspicious sign-ins or password activity.
5. Confirm whether the authentication method change was authorised by the legitimate account owner.
6. Determine whether additional identity or persistence activity occurred.

---

## Containment Workflow

If the MFA registration is confirmed as unauthorised, the investigation can progress to identity containment actions such as:

1. Revoke active user sessions.
2. Disable the affected account if required.
3. Remove the unauthorised authentication method.
4. Review recent sign-in activity for further compromise.
5. Investigate related identity activity for additional persistence.

---

## Detection Lifecycle

```text
Compromised Credential Simulation
        ↓
MFA Security Information Change
        ↓
Entra ID Audit Telemetry
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
Telemetry Investigation
        ↓
Alert Grouping Tuning
        ↓
Detection Revalidation
```

---

## Evidence

Evidence collected during the scenario includes:

- MFA registration simulation
- Entra ID audit telemetry
- KQL query results
- Microsoft Sentinel analytics rule configuration
- Entity mapping configuration
- Generated incidents
- Duplicate incident behaviour
- Alert grouping changes
- Tuned incident validation
- Microsoft Defender investigation context

See the [`evidence/`](./evidence/) directory for screenshots captured during the lab.

---

## Skills Demonstrated

- Microsoft Sentinel
- Microsoft Entra ID
- Azure Log Analytics
- Kusto Query Language (KQL)
- Entra ID AuditLogs analysis
- Entra ID SigninLogs analysis
- Identity threat detection
- Detection engineering
- Microsoft Sentinel analytics rules
- Entity mapping
- Alert enrichment
- Alert grouping
- Detection tuning
- Incident triage
- Identity persistence investigation
- Identity containment planning
- MITRE ATT&CK
