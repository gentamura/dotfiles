# Release

Prepare and execute a release to the specified environment.

## Environment

$ARGUMENTS

## Pre-Release Checklist

### Code Quality
- [ ] All tests pass
- [ ] `bun run build` succeeds
- [ ] No lint warnings
- [ ] No TypeScript errors

### Database
- [ ] Migrations tested in staging
- [ ] Rollback migration ready
- [ ] Data backup completed

### Infrastructure
- [ ] Environment variables configured
- [ ] Secrets updated if needed
- [ ] Scaling configured appropriately

### Documentation
- [ ] Changelog updated
- [ ] Release notes prepared
- [ ] Runbook updated

## Release Steps

1. **Final Verification**
   - Run full test suite
   - Verify build
   - Check staging environment

2. **Deploy**
   - Follow deployment procedure
   - Monitor deployment progress
   - Verify health checks

3. **Post-Deploy Verification**
   - Smoke test critical paths
   - Monitor error rates
   - Check performance metrics

## Rollback Plan

If issues detected:

1. Identify the issue
2. Decide: hotfix or rollback
3. If rollback:
   - Revert deployment
   - Rollback database if needed
   - Communicate to stakeholders

## Post-Release

- [ ] Monitor for 30 minutes
- [ ] Update status page
- [ ] Notify stakeholders
- [ ] Close related tickets
