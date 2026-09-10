# Detection Tuning Notes: Suspicious MFA Registration

## Initial Behaviour

The first validation run of the suspicious MFA registration detection generated multiple incidents for activity originating from a single MFA registration workflow.

Investigation of the underlying Microsoft Entra ID telemetry showed that one authentication method registration can generate multiple related audit events, including:

- `User registered security info`
- `User changed default authentication method`
- `User registered all required security info`

Because the initial alert grouping configuration required a strict match across all mapped entities, small differences between related audit events caused Microsoft Sentinel to separate the alerts into different incidents.

---

## Tuning Decision

The alert grouping configuration was changed to group related activity primarily by the affected **Account entity** over a **5-hour grouping window**.

Standard event grouping was retained so that the underlying event data and custom details remained available for investigation.

The goal was to correlate related authentication-method changes affecting the same account without losing useful event-level context.

---

## Validation

After updating the grouping configuration, the MFA registration simulation was executed again.

The subsequent test successfully consolidated **four related alerts** associated with the same test account into a **single Microsoft Sentinel incident**.

This confirmed that the revised grouping configuration reduced duplicate incident creation while retaining the relevant security telemetry for analyst investigation.

---

## Detection Engineering Lesson

This scenario demonstrated that detection tuning must account for the behaviour of the underlying telemetry.

A single user action does not necessarily correspond to a single security event. Microsoft Entra ID can generate multiple audit records for different stages of the same authentication-method workflow.

Effective Sentinel detection therefore requires validation of:

- Raw event behaviour
- Entity mapping
- Alert grouping
- Incident correlation
- Investigation context

Testing and tuning the rule against generated telemetry helped produce a more actionable incident for SOC triage.
