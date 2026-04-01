---
name: performance
description: Performance optimization. Triggers on slow, optimize, performance, speed, bundle size, latency.
---

## Performance Protocol
1. Measure BEFORE (Lighthouse, profiler, benchmarks).
2. Find actual bottleneck (not guessed).
3. Fix with simplest solution.
4. Measure AFTER with numbers.
**Frontend:** Code split, lazy load, WebP, defer JS, virtualize lists.
**Backend:** Add indexes, fix N+1, stream data, cache, async I/O.
