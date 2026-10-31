# Pre-ship security review prompt

Review this repository and the proposed diff for security vulnerabilities. Read the full code path from each lower-trust input to the protected resource or effect. Check authentication and authorization, broker and database access, secret exposure (including Git history), injection, unsafe file handling, dependency and container identities, Kubernetes privileges, and retry or logging paths.

For each claim, name the actor, entry point, strongest existing control, crossed boundary, concrete result, exact file and line, and smallest effective fix. Put demonstrated vulnerabilities, deployment-dependent leads, and hardening advice in separate sections. Do not assign a severity to a lead that still needs validation. Identify safe patterns and decoys you ruled out. Do not assume the reference Dockerfile or sink JSON is the active connector image.

Use source inspection and local dummy fixtures only. Do not access a running cluster, broker, database, external service, or real credential. If an isolated sandbox is unavailable, say which test is blocked. End with the files and trust boundaries reviewed and any gaps.
