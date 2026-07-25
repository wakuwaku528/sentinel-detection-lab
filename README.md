# Cloud SOC & Detection Engineering Lab

A modular, enterprise-grade cloud detection lab built to design, simulate, ingest, and detect adversarial techniques using Microsoft Sentinel, Azure Monitor Agent (AMA), and Kusto Query Language (KQL).

---

## Lab Architecture & Pipeline
1. **Telemetry Ingestion:** Domain Controller (`vm-ad-server-001`) streams Windows Security Events via Azure Monitor Agent (AMA) and Custom Data Collection Rules (DCR) into a centralized Log Analytics workspace.
2. **Baselining:** Establishing a clean operational baseline of standard business-hour interactive and network logons (`Event ID 4624`) prior to running adversary simulations.
3. **Detection Engineering:** Writing custom, MITRE-aligned KQL analytics rules with built-in threshold tuning to prevent alert shadowing.
4. **Incident Triage:** Automated routing of high-fidelity alerts into the unified Microsoft Defender portal for analyst validation.

---

## Attack Simulation & Detection Modules

| # | Attack Scenario | MITRE ATT&CK Mapping | Status | Key Artifacts |
|---|---|---|---|---|
| 01 | **Horizontal Password Spraying** | Credential Access (`T1110.003`) | Completed | [View Module](./attacks/01-password-spray/) |
| 02 | *Suspicious MFA Modification / Abuse* | Credential Access / Defense Evasion | Pending | Coming Soon |
| 03 | *Privilege Escalation via Group Membership* | Privilege Escalation (`T1078`) | Pending | Coming Soon |
| 04 | *Unusual Administrative Login Patterns* | Initial Access (`T1078.002`) | Pending | Coming Soon |

---

## Repository Structure
```text
sentinel-detection-lab/
├── attacks/
│   └── 01-password-spray/
│       ├── detection.kql
│       ├── README.md
│       └── evidence/
├── scripts/
│   └── simulation-scripts.ps1
└── README.md
