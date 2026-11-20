# mitodoke --- Product Concept

## 1. Overview

**mitodoke** is a quality-support platform for software development.

It structures the decisions and artifacts through which people reason
about software quality, makes the relationships between those artifacts
traceable, and mechanically identifies places that require renewed human
review when upstream information changes.

mitodoke does not manage or guarantee software quality on behalf of its
users. It supports the people who are responsible for quality by making
their decisions, relationships, and review obligations explicit and
machine-checkable.

> mitodoke helps people take responsibility for software quality; it does
> not take that responsibility away from them.

## 2. Name

**mitodoke** comes from the Japanese word **見届け** (*mitodoke*): to
watch something through to the end and confirm it with one's own eyes.

The one who sees things through is a person, not the tool. People follow
quality-related decisions and their consequences through the connected
development artifacts---from problems and requirements, through design
and risks, to test conditions and implemented test cases---and confirm
that each review has actually been carried out, including the reviews
that an upstream change makes necessary.

mitodoke supports that act of seeing through. It shows what remains to
be confirmed and records what a person has confirmed. The name describes
this supporting role without claiming that the application itself
guarantees quality.

## 3. The problem mitodoke addresses

AI-assisted software development makes implementation faster and
increasingly automatable. However, generating code and tests does not by
itself establish that the right problem is being solved, that the design
addresses the relevant risks, or that the tests meaningfully examine the
required behavior.

The central challenge is therefore not simply producing more tests or
collecting test results. It is helping people identify and reason about
the quality questions that should be considered during development.

In particular:

-   A requirement or design decision should be connected to the risks it
    introduces or addresses.
-   Risks should lead to explicit test conditions.
-   Test conditions should inform the test cases selected and
    implemented for a given test plan.
-   Changes to upstream artifacts should make potentially affected
    downstream decisions visible.
-   It should be possible to distinguish generated or updated content
    from content that a person has reviewed.

Without these relationships, documents can exist independently while
important assumptions and review obligations remain invisible.

## 4. Product philosophy

### 4.1 Quality is a human responsibility

Quality is not something mitodoke can guarantee merely by validating
metadata, checking links, or observing successful CI runs.

People remain responsible for:

-   explaining why a problem, requirement, or design is appropriate;
-   identifying and evaluating risks;
-   deciding whether the identified test conditions are sufficient;
-   deciding the scope of each test plan;
-   reviewing AI-generated artifacts and tests;
-   determining whether an upstream change requires a downstream change
    or whether the existing content remains valid;
-   carrying out the reviews and recording that they have been
    performed.

This is both **accountability** (being able to explain and stand behind
a decision) and **responsibility for execution** (actually performing
the necessary work).

If an operator chooses not to follow the review process, mitodoke cannot
make that process effective on their behalf. The platform is designed to
support a quality-conscious operation, not to substitute for one.

### 4.2 Machines support judgment; they do not replace it

mitodoke uses machine-checkable structure and automation to make quality
work more effective.

Automation can:

-   validate document structure and relationships;
-   identify missing or inconsistent links;
-   detect upstream changes that may require downstream review;
-   report stale or unverified artifacts;
-   provide a consistent basis for CI checks;
-   assist AI and human workflows with structured information.

Automation cannot determine, by itself, whether a requirement is
genuinely valuable, whether a risk assessment is reasonable, or whether
a test is sufficient to provide confidence in the behavior.

The boundary is intentional:

**Machines identify, connect, compare, and report. People judge, decide,
review, and take responsibility.**

### 4.3 Make relationships explicit

mitodoke treats the relationships between development artifacts as
first-class information.

The goal is not to impose documentation for its own sake. It is to make
the reasoning behind development and testing inspectable and traceable.

A document should not merely exist; its place in the reasoning structure
should be understandable.

### 4.4 Preserve local responsibility and replaceability

mitodoke should have a clearly bounded responsibility: support
quality-related development activities through structured artifacts,
relationship checks, and review signals.

It should not absorb unrelated responsibilities such as implementing the
application, owning every test runner, or becoming the authority that
decides whether a product is good.

External tools should be used where they already perform a suitable job.
Their use should not automatically lead to reimplementation or premature
abstraction. At the same time, the product's own document model and
contracts should remain understandable independently of a particular
implementation tool wherever practical.

## 5. Conceptual document model

The current model describes a chain of reasoning from the problem being
addressed to the tests that exercise the resulting software.

  -----------------------------------------------------------------------
  Artifact                            Purpose
  ----------------------------------- -----------------------------------
  **`solution`**                      Describes the concept, problem, or
                                      solution being pursued.

  **`use_case`**                      Describes a requirement or usage
                                      situation arising from the
                                      solution.

  **`requirement`**                   States what the software or system
                                      must satisfy.

  **`design`**                        Describes how the requirements are
                                      addressed by the design.

  **`risk`**                          Captures risks arising from or
                                      associated with requirements and
                                      design decisions.

  **`test_condition`**                Expresses a test perspective or
                                      condition derived from a risk.

  **`test_plan`**                     Defines the scope and approach for
                                      testing a solution.

  **`test_case`**                     Represents a concrete test case
                                      selected and implemented in
                                      relation to a test condition and
                                      test plan.
  -----------------------------------------------------------------------

The model is intended to support traceability across these artifacts.
The exact relationships and constraints are defined by the document
schema and its validation rules.

### 5.1 `risk` is a required bridge to test conditions

A core invariant is that every **`test_condition`** must be derived through
a **`risk`**.

This keeps test conditions connected to an explicit quality concern
rather than allowing them to become an ungrounded list of test ideas.

The relationship is intentional: test conditions are not simply a
checklist that must all be executed. They are perspectives that should
be considered when deciding what testing is appropriate.

### 5.2 Test conditions and test plans have different roles

A **`test_condition`** describes a test perspective derived from a risk. It
represents something to consider, not necessarily something that must
always be executed.

A **`test_plan`** determines the scope and approach of testing. Based on
that plan, people decide which conditions should be addressed and
instantiate concrete **`test_case`** items.

The intended traceability is therefore indirect:

**`test_plan` → `test_case` → `test_condition` → `risk`**

A direct relationship requiring every `test_plan` to enumerate every
`test_condition` would incorrectly imply that all identified conditions
must be executed by every plan.

### 5.3 `test_case` and test implementation traceability

The current convention associates a **`test_case`** with its test-code
resource, with a one-to-one relationship between a `test_case` and a test-code
file/resource as defined by the project contract.

This provides traceability between the documented test intent and the
implementation artifact. It does not, by itself, prove that every
individual test function in that file is correct or that the test is
capable of detecting the intended defect.

That distinction should remain explicit: traceability is necessary for
inspection, but is not proof of test effectiveness.

## 6. Generated and verified states

mitodoke uses the `generated` and `verified` front-matter properties
associated with the Open Knowledge Format (OKF) convention adopted by
the project.

They represent different kinds of information:

-   **`generated`** records the generation/update state of an artifact.
-   **`verified`** records confirmations of an artifact, each as an
    entry stating who confirmed it (`by`) and when (`at`). Following
    OKF, the confirmer may be a person or a machine.

Only entries whose `by` is `human:<id>` count as human review. A human
entry is not an automated assertion that a document is correct. It
represents a human act of inspection. After reviewing the relevant
content, a person adds the entry and commits that change.

This makes the review state visible and version-controlled. It also
preserves the distinction between content produced or changed by
automation and content that a person has subsequently reviewed.

Entries made by machines are never counted as human review, which keeps
design principle 6 (§11). They do, however, advance the reference time
used to detect stale downstream artifacts (§7). If a machine entry is
newer than an upstream change, the artifact is no longer reported as
awaiting review, even though no person has looked at it. Principle 6
forbids treating content as human-reviewed; it does not stop a machine
confirmation from clearing the review-pending state. Projects that
allow machines to write `verified` should do so with this in mind.

## 7. Change impact and review workflow

mitodoke uses document relationships together with `generated` and
`verified` information to identify downstream artifacts that may need
renewed review after an upstream change.

A typical workflow is:

1.  An upstream artifact is changed.
2.  Relationship information is used to identify connected downstream
    artifacts.
3.  The validation scripts and CI detect downstream artifacts whose
    review state no longer reflects the upstream change.
4.  The affected artifacts are reported for human inspection.
5.  A person reviews each artifact and decides whether its content needs
    to change.
6.  If a change is necessary, the person or an AI-assisted workflow
    updates the content.
7.  Once the person has reviewed the result---including a decision that
    no content change is necessary---they update `verified` and commit
    the review.

The important distinction is that an upstream change does not imply that
every downstream artifact must change. It implies that relevant
downstream decisions may need to be reconsidered.

mitodoke surfaces that obligation; the person determines the outcome.

## 8. SARA and external tools

The current implementation uses **SARA** to describe and validate
relationships between documents.

SARA is an intentional external dependency. mitodoke does not aim to
reimplement SARA or build a general abstraction layer for hypothetical
alternative engines.

The document structure and relationship requirements are conceptually
simple enough that another suitable tool could potentially serve the
same role in the future. That possibility is not, by itself, a reason to
add abstraction or multiple-engine support now.

The product should use a tool that performs the required job well while
keeping its own domain model and quality rules clear.

## 9. CI and test execution

CI is used to execute automated checks and surface violations or review
obligations. The hosting platform's CI logs are treated as the record of
execution.

However, three different claims must not be conflated:

1.  A test was executed.
2.  A test passed.
3.  The test meaningfully verifies the intended behavior or quality
    concern.

CI can provide evidence for the first two. The third depends on the
quality of the test design and implementation, which is why mitodoke
emphasizes the reasoning from requirements and design through risks and
test conditions.

In AI-assisted development, it is desirable to execute tests across the
testing levels---from end-to-end through unit tests---in CI where
practical. But mitodoke's central purpose is not to become a
test-execution or log-aggregation platform. Its central purpose is to
help people define and trace the test intent that makes those executions
meaningful.

## 10. Scope and non-goals

### mitodoke is intended to

-   structure quality-related development artifacts;
-   make relationships between those artifacts explicit;
-   validate document contracts and relationship constraints;
-   detect potentially stale downstream artifacts after upstream
    changes;
-   distinguish generated content from human-reviewed content;
-   integrate with CI to report violations and review obligations;
-   support AI-assisted and human workflows for creating and reviewing
    artifacts;
-   encourage consideration of testing throughout development, in line
    with the project's adoption of the ISTQB/JSTQB testing-process
    perspective and holistic testing.

### mitodoke is not intended to

-   guarantee software quality automatically;
-   replace human judgment, accountability, or execution responsibility;
-   decide whether requirements, designs, risk assessments, or tests are
    substantively correct;
-   treat every `test_condition` as a mandatory test execution;
-   equate a successful CI run with adequate test coverage or test
    effectiveness;
-   become a general-purpose test runner or CI log management system;
-   reimplement SARA without a concrete need;
-   impose a particular programming language, test framework, or
    application architecture as part of its core model.

## 11. Design principles

The following principles summarize the product's intended direction.

1.  **Support, do not own quality.** The application supports quality
    work; people remain accountable for quality decisions.
2.  **Make reasoning traceable.** Connect problems, requirements,
    design, risks, test conditions, plans, and implemented cases.
3.  **Require risk-grounded test conditions.** A `test_condition` must be
    connected to a `risk`.
4.  **Separate consideration from execution.** `test_condition` describes a
    perspective; `test_plan` and `test_case` describe selected testing work.
5.  **Surface change impact.** Upstream changes should make potentially
    affected downstream decisions visible.
6.  **Treat verification as a human act.** Automation must not silently
    mark content as human-reviewed.
7.  **Use automation for mechanical certainty.** Validate structure,
    relationships, consistency, and review state where rules can be made
    explicit.
8.  **Do not claim what cannot be proven.** Structural validity and
    successful CI execution do not establish substantive correctness.
9.  **Keep responsibilities bounded.** Prefer clear contracts and
    composable tools over an application that absorbs unrelated jobs.
10. **Avoid speculative abstraction.** Keep external dependencies
    replaceable in principle without implementing hypothetical
    alternatives prematurely.

## 12. Product statement

**mitodoke is a quality-support platform that makes software-development
decisions and their test implications traceable, detects when upstream
changes call downstream decisions into question, and helps people carry
out their responsibility for quality.**

It does not make quality decisions on behalf of people. It makes the
structure, consequences, and review obligations of those decisions
visible and machine-checkable.
