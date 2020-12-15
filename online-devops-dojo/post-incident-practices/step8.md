Chun shares best practices on how to conduct a blameless post-mortem and details on a key metric the team should focus on in terms of post incident practices.

**Post Incident Practices**

| From || To |
| --- | --- |--- |
| Seeking Single Root Cause for an outage | ➡ | Addressing the multiple systemic contributing factors to an outage   |
| Prevention (only)   | ➡ | Breaking down TTR (time to resolve components) |
| Blameful post-mortems  | ➡ | Blameless post-mortems  |
| Surface Level post incident reviews   | ➡ | Strategic Level understanding and improvement |

**Mean Time to Recover (MTTR) Metric**

The key metric for Post Incident Practices is Mean Time to Recover (MTTR). MTTR captures the mean (average) time it takes to recover from a production issue.

Typically the metric is an average of the production downtime calculated across the last ten downtimes.

The hope and expectation is that MTTR will trend lower as DevOps maturity grows and incident practices improve by using the following process:

* Measure

`MTTR = MTTD (Detect) + MTTI (Isolate) + MTTF (Fix)`

* Determine top contributing factors for preventing, detecting, isolating, and fixing issues.

* Add remediation steps to prioritized team backlog.
