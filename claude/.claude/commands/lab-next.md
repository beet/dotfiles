---
description: Pick, vet and claim the next LAB ticket by the team's pull order — board only, no code
argument-hint: [optional filter — a label like "NutriPATH", a project, a priority, or a keyword]
---
 
# Claim the next LAB ticket
 
Find the right ticket, prove it is actually pullable, claim it, and stop. **This command does not write code** — hand off to `/lab-ticket` or to the developer once the ticket is claimed.
 
If the Linear MCP server is not connected, stop and say so in your first reply.
 
## 1. Read the rules first
 
Read the LAB team's Linear documents that govern how work is pulled — **The LabMaster Way** (§9 pull order, §10 Definition of Ready) and **The board runs itself, except where it must not**. Read any document they point to. These change; do not answer from memory.
 
Note the revision date on each. If a rule you are about to apply was changed recently, say so.
 
## 2. Rank the board
 
Apply §9's order, not "oldest first" and not "what looks interesting":
 
1. `Urgent` — drop everything
2. `Handover` tickets — finish in-flight work before starting new work
3. `Ready to Merge` — highest-leverage column for a human
4. `QA` — humans only
5. `High`, then `Medium`, then `Low`
6. Within a priority, **smallest estimate first** `$ARGUMENTS`, if given, filters the candidate set — but does not change the ordering above.
 
## 3. Vet each candidate before offering it
 
Reject, and say why, anything that fails Definition of Ready:
 
- Missing an `Area`, `Customer` or `Product` label
- Estimate above 8, or absent
- **Carries a `Needs` label** — that is a gate, not a queue position. Skip unless you are there to deliver that specific input.
- `Agent > Human required`, unless the user is a human and the work is theirs to do
- No prior PR or branch linked when one exists
- **Estimated 0** — that is a brief or parent issue, not work. Its children carry the points.

Also read the `Agent` label and report it: `Ask first` means post an approach and wait before building; `Handover` means a branch and probably a draft PR already exist.
 
## 4. Check the working state before claiming
 
- **Does the user already have a ticket in `In Progress`?** That is the WIP limit, and it is one. `Blocked` does not count. If they do, say so and ask before claiming a second. **Is the candidate still free?** Re-query its state and assignee *immediately* before the mutation. Tickets get taken mid-conversation; a list read two minutes ago is not evidence.
- **Are siblings in flight?** If the ticket belongs to a project, check what else in it is `In Progress` and who has it — their branches probably belong stacked, not beside.

## 5. Claim it
 
Three steps, all of them:
 
1. Assign it to the user.
2. Move it to `In Progress`.
3. Comment naming the branch and what they intend to do.

**If the session's Linear credential is not the user's own account**, do not post step 3 — a claim comment under someone else's name is worse than none. Hand the user paste-ready text instead and say why. Report any step you could not complete rather than implying a full claim.
 
## 6. Report
 
- The ticket, and **why it won on the pull order** — one line.
- What you skipped above it and why. Gates and unready tickets are the useful part.
- Any genuine tie, and what would flip it.
- The branch name, and the comment text if step 3 was left to the user.
- Traps in the description: citations pinned to a commit that has since moved, work said to be "already built" that a sibling branch has since changed, `Ask first`.

## 7. Report board hygiene you noticed, but do not fix it
 
Say it; do not act on it without being asked. Things worth naming:
 
- A ticket in `QA` assigned to a bot or session account — nobody has actually been asked, and it will sit there
- A ticket in `Blocked` with no comment saying what blocks it or who owns the answer
- A PR held up by unresolved review threads opened by a person — no repair bot is coming
- A ticket whose PR the sweep cannot resolve — no state change, no bot, silent

Finish with what the user should do next, in one sentence.

