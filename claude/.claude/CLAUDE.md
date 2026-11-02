# Comments

**Maximum two lines. A third line is a bug.** Comment the constraint, not the change: a comment
earns its place only when it states something a reader cannot recover from the code and would
otherwise re-derive the hard way — a platform rule, a data-model trap, a measured number. The same
applies in specs: the scenario name carries the intent, so the comment above it only has to carry
what the name cannot.

Before writing one, ask: **would this still be true in a year, with the ticket forgotten?** If not,
it belongs somewhere else:

| What you want to say | Where it goes |
| --- | --- |
| Why this approach and not the other one | the change's design doc (`design.md` under OpenSpec) |
| What the system must do | the spec delta, and the name of the test that proves it |
| What QA found, who asked for it, when | the ticket |
| What this commit changes | the commit message |

```ruby
# Cut — narrates the change, restates the code, and re-tells a bug that is now fixed:
# Write each row's place in the collection onto its heading, where CSS prints it. Off the same
# walk as assignPositions and for the same reason — the set that counts is the non-destroyed
# rows, in order — but this one is not conditional on `sortable`, and it counts from one because
# it is read by a person rather than sent to the server. Deliberately NOT derived from what is
# on screen. This replaced a CSS counter, which could only ever count laid-out boxes:
# `nested-filter` hides a row with `display: none`, so every number below the first hidden row
# shifted up and a filtered list told the author that section 14 was section 3 (LAB-1289).

# Keep — the constraint, and a ticket reference for anyone who wants the rest:
# Each row's place in the collection, onto its heading for CSS to print. Never derived from what
# is on screen: that is what broke the CSS counter this replaces under a filter (LAB-1289).
```

A ticket reference is the compression. `(LAB-1289)` is four words that buy the reader the whole
story if they want it, and cost nothing if they do not.

**Density already in a file is not permission.** LabMaster's `nested_filter_controller.js` opens
with thirty lines of prose and `report_template_editor.css` with thirty-three, and its CLAUDE.md is
longer than both. Do not match a file's density just because it is what you are reading.

A class-level purpose comment — where a project asks for one, as LabMaster does — is the standing
exception, and it is one or two lines too.

# Method definitions

**Never write an endless method definition.** `def code = @code` is not shorter in any way that
helps a reader: it reads as an assignment until the eye reaches the `def`, it cannot grow a second
line without being rewritten, and it hides the body from every `def`/`end` fold and jump. Write
`def ... end` even for a one-expression body, and even for a bare attribute or delegation.

**The surrounding code is not permission.** Even if many pre-existing methods
in the repo follow that pattern, matching the local idiom is exactly how the
habit spreads. Leave the existing ones alone — rewriting them is churn, and a
diff that is half style is a diff nobody reads — but do not add another.

# Running specs

**A comment-only, whitespace-only or doc-only edit gets no verification run.** No specs, no build,
no linter — `git diff` is the check. The one exception, and read it off the diff rather than
assuming: an edit to comment *delimiters* (`<%#` vs `<%`, commenting a live line out) can change
behaviour; text inside intact delimiters cannot.

**Never run a whole system-spec directory locally.** Run the files the change touches, then push:
CI is parallel and the same sweep is minutes there, while locally it is serial and holds the only
browser and test database. The long tail is also where the flakes are — of six failures in one such
sweep, one was real. A failure seen once inside a batch is not a finding: re-run that file alone,
and diff against a clean tree before calling it a regression.

**Prefer a request spec to a system spec.** Drive the real flow over HTTP — that recovers most of
the integration value at a fraction of the cost. Reserve system specs for what genuinely needs a
browser (geometry, drag-and-drop, JS timing) and keep them to the user-facing happy path.

# Assertions

**An assertion that reuses the implementation's own expression cannot fail.** It does not merely
miss the defect, it vouches for it. Assert the requirement's observable value — a reference number,
a concrete string — never `subject.some_method` mirrored from the code under test, and build the
fixture so the right and wrong answers actually differ. Before trusting a new example, revert the
fix and watch it go red; if it stays green it is not a test.

# Justifications

**Verify the claim before writing the reason.** A justification that sounds right and was never
checked is worse than no comment: it reads as authoritative and stops the next person checking.
"X is often the case", "this can't happen", "the convention here is Y" — each is a thing to run,
grep, or date against git history. If it cannot be checked, say so or leave it out.
