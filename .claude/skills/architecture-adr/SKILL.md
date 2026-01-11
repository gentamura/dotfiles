---
name: architecture-adr
description: Use this skill to create Architecture Decision Records (ADRs). Invoke when making significant technical decisions that affect system architecture, technology choices, or design patterns.
---

# Architecture Decision Record

Create and maintain ADRs for significant technical decisions.

## When to Create an ADR

- Choosing between technologies or frameworks
- Defining architectural patterns
- Making trade-offs with long-term implications
- Decisions that are hard to reverse
- Choices that affect multiple teams or systems

## Process

### 1. Research Context

- Review existing architecture and decisions
- Identify constraints (technical, business, regulatory)
- Gather requirements and quality attributes
- Consult with stakeholders

### 2. Evaluate Options

For each option:
- List concrete pros and cons
- Consider maintenance and operational impact
- Evaluate against quality attributes
- Estimate effort and risk

### 3. Make and Document Decision

Use the template below to capture the decision.

## ADR Template

```markdown
# ADR-[NUMBER]: [TITLE]

## Status

[Proposed | Accepted | Deprecated | Superseded by ADR-XXX]

## Date

[YYYY-MM-DD]

## Context

[What is the issue? What forces are at play?]
- Business context
- Technical constraints
- Quality requirements

## Decision

[What is the change we're making?]

We will use [decision] because [primary reason].

## Options Considered

### Option 1: [Name]

**Description:** [Brief explanation]

**Pros:**
- Pro 1
- Pro 2

**Cons:**
- Con 1
- Con 2

**Effort:** [Low | Medium | High]

### Option 2: [Name]

[Same structure]

### Option 3: [Name] (if applicable)

[Same structure]

## Consequences

### Positive
- [Benefit 1]
- [Benefit 2]

### Negative
- [Drawback 1 and how we'll mitigate]

### Neutral
- [Side effect that's neither good nor bad]

## Implementation Notes

- [Key implementation considerations]
- [Migration steps if applicable]
- [Monitoring/validation approach]

## References

- [Link to related ADRs]
- [Link to documentation]
- [Link to relevant discussions]
```

## File Naming Convention

```
docs/adr/
├── 0001-use-nextjs-for-frontend.md
├── 0002-adopt-drizzle-orm.md
├── 0003-aws-ecs-for-deployment.md
└── README.md (index of all ADRs)
```

## Review Checklist

- [ ] Context clearly explains the problem
- [ ] All viable options are considered
- [ ] Pros/cons are concrete, not vague
- [ ] Decision rationale is clear
- [ ] Consequences are honest (including negatives)
- [ ] Implementation path is outlined
