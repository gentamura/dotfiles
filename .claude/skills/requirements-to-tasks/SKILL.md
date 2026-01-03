---
name: requirements-to-tasks
description: Use this skill to break down requirements into user stories, acceptance criteria, and actionable tasks. Invoke when starting a new feature or receiving new requirements.
---

# Requirements to Tasks

Transform requirements into structured, actionable work items.

## Process

### 1. Understand the Requirement

- Identify the core user need
- Clarify the scope and boundaries
- Note constraints (technical, business, time)
- Identify stakeholders

### 2. Create User Stories

Format each story as:

```
As a [user type],
I want [capability],
so that [benefit].
```

Include:
- Clear acceptance criteria (Given/When/Then)
- Edge cases and error scenarios
- Non-functional requirements (performance, security)

### 3. Technical Breakdown

For each user story:

1. Identify required changes by layer:
   - Frontend (UI, state, routing)
   - Backend (API, business logic)
   - Database (schema, migrations)
   - Infrastructure (if needed)

2. Create tasks with:
   - Clear description
   - Complexity indicator (S/M/L)
   - Dependencies
   - Definition of done

### 4. Risk Assessment

- Technical risks and mitigations
- Dependency risks
- Knowledge gaps

## Output Template

```markdown
# Feature: [Name]

## Summary
[1-2 sentence description]

## User Stories

### US-1: [Title]
As a [user], I want [feature] so that [benefit].

**Acceptance Criteria:**
- [ ] Given [context], when [action], then [result]
- [ ] Given [context], when [action], then [result]

**Tasks:**
1. [Task] (S) - [layer]
2. [Task] (M) - [layer], depends on #1

---

## Technical Notes
- [Architecture decisions]
- [Integration points]

## Risks
| Risk | Impact | Mitigation |
|------|--------|------------|
| ... | H/M/L | ... |

## Open Questions
- [ ] Question needing clarification
```
