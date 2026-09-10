# Microsoft Sentinel Cloud SOC & Detection Engineering Lab

A hands-on cloud SOC project built in Microsoft Azure to develop and validate security monitoring, detection engineering, alert triage, and identity-focused incident investigation workflows.

The project progresses from building an Active Directory target environment and security telemetry pipeline, through horizontal password spraying detection, to Microsoft Entra ID persistence detection using suspicious MFA registration.

> **Environment:** Independent cybersecurity lab for hands-on security operations and detection engineering practice. This is not a commercial production SOC environment.

---

## Project Overview

This project demonstrates an end-to-end security monitoring and detection workflow using Microsoft Sentinel and Microsoft Defender.

Rather than treating each exercise as an isolated lab, the environment was developed progressively across three phases:

1. Build the target infrastructure and identity environment.
2. Configure and validate security telemetry collection.
3. Establish normal authentication baselines.
4. Simulate adversary activity.
5. Analyse the resulting telemetry with KQL.
6. Develop custom Microsoft Sentinel analytics rules.
7. Generate and investigate security incidents.
8. Tune detection logic and alert grouping based on observed results.

### SOC Workflow

```text
Target Environment
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
Incident Generation
        ↓
SOC Triage
        ↓
Detection Tuning
