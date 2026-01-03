---
name: release-runbook
description: Use this skill for release preparation and execution. Invoke when deploying to staging or production environments.
---

# Release Runbook

Structured release process with verification and rollback procedures.

## Release Types

| Type | Scope | Risk | Approval |
|------|-------|------|----------|
| Patch | Bug fixes only | Low | Self |
| Minor | New features, backwards compatible | Medium | Team |
| Major | Breaking changes | High | Stakeholders |

## Pre-Release Checklist

### Code Quality

- [ ] All tests pass locally
- [ ] `bun run lint:fix` passes
- [ ] `bun run build` succeeds
- [ ] No TypeScript errors
- [ ] No console.log in production code

### Testing

- [ ] Unit tests cover new code
- [ ] Integration tests pass
- [ ] E2E tests pass (if applicable)
- [ ] Manual QA completed

### Database

- [ ] Migrations tested in staging
- [ ] Rollback migration prepared
- [ ] Data backup completed
- [ ] No breaking schema changes (or migration plan exists)

### Infrastructure

- [ ] Environment variables configured
- [ ] Secrets updated if needed
- [ ] Resource scaling appropriate
- [ ] Monitoring/alerts configured

### Documentation

- [ ] CHANGELOG updated
- [ ] Release notes drafted
- [ ] API documentation updated
- [ ] Runbook updated if needed

## Release Process

### 1. Prepare Release

```bash
# Create release branch (if using git-flow)
git checkout -b release/v1.2.3 develop

# Update version
npm version patch|minor|major

# Update CHANGELOG
# Add release notes
```

### 2. Final Verification

```bash
# Run all checks
bun run lint:fix
bun run build
bun run test

# Verify in staging
# - Core user flows
# - New features
# - Known edge cases
```

### 3. Deploy

```bash
# Tag the release
git tag -a v1.2.3 -m "Release v1.2.3"

# Push to trigger deployment
git push origin v1.2.3

# Or manual deployment
# [project-specific deployment command]
```

### 4. Post-Deploy Verification

Immediately after deployment:

- [ ] Health checks pass
- [ ] Application loads
- [ ] Core flows work (login, main features)
- [ ] No error spikes in monitoring
- [ ] Performance metrics normal

Monitor for 30 minutes:

- [ ] Error rates stable
- [ ] Response times normal
- [ ] No memory leaks
- [ ] Database performance stable

### 5. Communicate

- [ ] Update status page
- [ ] Notify stakeholders
- [ ] Close related tickets
- [ ] Update project board

## Rollback Procedure

### When to Rollback

- Critical functionality broken
- Error rate exceeds threshold
- Performance severely degraded
- Security vulnerability discovered

### Rollback Steps

1. **Decide**: Hotfix or rollback?
   - Hotfix: Issue is small, fix is obvious
   - Rollback: Issue is complex or unknown

2. **Execute Rollback**

```bash
# Revert to previous version
# [project-specific rollback command]

# Or redeploy previous tag
git checkout v1.2.2
# [deploy]
```

3. **Database Rollback** (if needed)

```bash
# Run rollback migration
# [project-specific command]
```

4. **Verify**

- [ ] Previous version running
- [ ] Core functionality restored
- [ ] Error rates normalized

5. **Communicate**

- [ ] Update status page
- [ ] Notify stakeholders
- [ ] Create incident ticket

## CHANGELOG Format

```markdown
# Changelog

## [1.2.3] - YYYY-MM-DD

### Added
- New feature description

### Changed
- Updated behavior description

### Fixed
- Bug fix description

### Security
- Security fix description
```

## Release Notes Template

```markdown
# Release v1.2.3

## Highlights
- [Main feature or fix]

## What's New
- Feature 1
- Feature 2

## Bug Fixes
- Fix 1
- Fix 2

## Breaking Changes
- [None | List of breaking changes]

## Upgrade Notes
- [Any special upgrade instructions]
```
