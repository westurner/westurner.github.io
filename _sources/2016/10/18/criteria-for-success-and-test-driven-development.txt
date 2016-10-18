Criteria for Success and Test Driven Development
================================================

There are conceptual similarities and differences among
TDD, the Scientific Method, and Goal-Directed Organizational Planning.

How does Test-Driven-Development (TDD) relate to experimental
hypotheses?

When practicing the Scientific Method (and keeping with Design of
Experiments), we're supposed to **start with a hypothesis**,
experiment, and then **test the hypothesis**
before drawing a conclusion.

- If the hypothesis is not met (in terms of statistical constraints,
  boolean test pass/fail), then we reject the conclusion.
- With Six Sigma DMAIC (Define, Measure, Analyze, Implement, Control)
  in the Control step we re-evaluate whether the implemented approach
  is achieving the intended objectives that we defined ahead-of-time.

  - "Validated Learning" emphasizes the need to control given changes
    in predefined metrics, as well.

- Control Theory and Systems Theory are all about how
  changes in inputs (and feedback) affect measurable state
  (outputs, systemic outcomes).


History, and various domains of science and policy, is chock-full of
examples of how attempts to Optimize (Minimize or Maximize) for certain
metrics have resulted in Unintended Consequences: where changes in
unmeasured variables are resultant from (or just "linked with", in terms
of Confounding, Correlation and Causation) attempts to optimize. Can you
think of a few salient examples in your domains of knowledge?

There is math for solving multi-dimensional ("high-dimensional")
optimization problems.

- MCDA (*Multiple-Criteria Decision Analysis*) intends to find -- often
  multiple -- solutions to multi-dimensional optimization problems.

Most systems are inherently multi-dimensional: there are stocks and
flows (sort of like nodes with magnitude and uni-/bi-directional edges
with magnitude). A systems metaphor: a balloon animal filled with water.

We'd like to think that software is more discrete; that is,
software is descriable in terms of how output results from changes in
input variables.

Formal methods of software design and analysis are often cost-prohibitive.
Practically, the problems we intend to solve with software are often
ill-specified: we don't start with a complete functional specification,
we start with a vague idea of the problem we'd like to solve
(more efficient, more auditable, more logs) and work from there.
Agile development methods are designed to support teams of stakeholders
who are seeking continuous success in satisfying changing objectives.

So, then, there are two things to optimize (maximize) for
when attempting to deliver software which successfully achieves customer
expectations:

- Functional Specification Coverage: whether all of the desired
  behaviors are enumerated in at least one test.

    - Each Use Case and/or User Story should have at least one test.
      (Behavior-Driven-Development tools make it easier to write
      these tests with something like natural language;
      so that developers/engineers can do what they do best).
    - User Stories can be written and rewritten from
      the 5 W's (Who, What, When, Where, Why)
      to a Given-When-Then (and Why) pattern:

      - "Users can register for user accounts"
      - "As an unregistered user, when I complete the registration form,
        and then click on the confirmation link sent to my email,
        then I have a registered user account (obviously: in order to
        onboard new users)"

- Code Coverage: whether all of the actual code in the software is
  covered by at least one test.

  - When some of the tests no longer pass, this is called "breaking the
    build". Teams working with Continuous Integration (*CI*) are aware
    of this because all of the tests run for every change to the software.

    - When the build breaks, it is the whole team's (and specifically,
      the person whose changes broke the build's) responsibility to
      stop what they are doing and un-break the build (often by just
      "backing out" the new changes (where they can remain in a separate
      feature branch)) so that the whole team is not blocked.
    - Teams devise various ways to indicate that the build is broken
      (CI emails, a *build lamp*, respectful verbal indications).

  - Function Coverage, Statement Coverage, Branch Coverage, Condition
    Coverage:

    Statement Coverage is a Code Coverage metric for
    determining whether each text line of the software is executed by the tests.
    Statement Coverage can be misleading for a number of reasons:

    1. There may be multiple branches on the same line.

      .. code:: python

          def func(a, b):
              if (a > 10) or (b < 20):
                  return True

          def test_func():
              assert func(271, 314)  # 100% coverage
              assert func(0, 0)      # still 100% coverage

    So, optimizing for Statement Coverage (when what we really want is
    *Branch Coverage*) can be misleading: can lead to false confidence.

    Branch Coverage and Statement Coverage **are not** independent
    measurements: if there's high Branch Coverage, there's likely also
    high Statement Coverage. Stated another way, change in Statement
    Coverage can be predicted given change in Branch Coverage. Is this
    confounding?

    .. note:: Because Branch Coverage and Statement Coverage **are not**
       *conditionally independent*, there are a number of mathematical
       analyses which are not appropriate (e.g. Bayesian inference).

       It can be said, then, that Branch Coverage and Statement Coverage
       are not *independent components*.

How does TDD relate to goal-driven organizational planning?

How do we know whether we've gotten there if we haven't yet defined
where we need to be?

Organizations define criteria for success:

- Mission
- Goals
- Objectives / Targets
- Indicators / Metrics / Key Performance Indicators

In terms of Test-Driven-Development, many organizational "tests"
are not yet "passing" ("reasonability", "realism").

There's an acronym for defining objectives: "SMART".
There are various interpretations of each of the letters.
One such interpretation is "Specific, Measurable, Achievable, Relevant,
Time-Bound". Here, we'll assume that a Goal is more of a high-level
grouping for one or more objectives (though it could be argued that
really all we have are nested sets of Goals or nested sets of
Objectives):

- Are we upholding the Organizational Mission?
- Is this objective {S, M, A, R, and T}?
- Is this objective Measurable?
- Is this objective Achievable (Assignable)?
- [...]

With tests for things in the future, we can define confidence intervals
(low, medium, high) as e.g. "pessimstic", "realistic", and "optimistic".

Assuming the objective is to maximize,
given an interval,
there are then four possible boolean tests for success
(or just one, if we limit ourselves to TDD pass/fail):

- Is the metric between the low and high thresholds?
- Is the metric above the low threshold?
- Is the metric within a defined threshold around the medium threshold?
- Is the metric below the high threshold?

System Administrators sometimes define events for these types of
threshold intervals:

- If utilization is below L, reduce the number of allocated servers.
- If utilization is above H, increase the number of allocated servers.

Organizations sometimes define events for these types of threshold
intervals:

- If we reach our sales target by date/time, everyone gets a raise. (See
  also: profit sharing).
- If the planetary temperature increases by n degrees,
  we'll suddenly realize we need to minimize the effects of climate
  change. (And, by then, it'll be too late)

These are *reactive* approaches.

TDD is proactive, in that we test first, early, and often.

So, there are differences and similarities between defining criteria for
success in software development and in adaptive, proactive,
organizations.

A bit about the Global Goals:

- The Global Goals for Sustainable Development are also known as
  the United Nations Sustainable Development Goals (SDGs).
- There are 17 Global Goals (**#Goal1** -- **#Goal17**).
- There are Targets for each Goal, and there are Indicators for Targets:

  - Goal

     - Target

        - Indicator(s)

- Some Indicators are relevant to multiple Targets.
- All Indicators should be relevant to all of us ("you people").
- The UN Millennium Development Goals were through 2015.
- The UN Sustainable Development Goals are through 2030.

  - By 2030, we intend to be able to say that we've achieved ( or
    exceeded) each Target, given an evaluation of the Indicators. This
    is our **criteria for success**.

    - We aren't yet passing the tests we've set for ourselves.
    - We're all working to find and implement solutions for achieving
      these Targets in our own states and worldwide.


Concepts / References

- https://westurner.org/2016/10/17/teaching-test-driven-development-first.html
- https://en.wikipedia.org/wiki/Test-driven_development
- https://en.wikipedia.org/wiki/Scientific_method
- https://en.wikipedia.org/wiki/Hypothesis
- https://en.wikipedia.org/wiki/Design_of_experiments
- https://en.wikipedia.org/wiki/Six_Sigma#DMAIC
- https://en.wikipedia.org/wiki/Validated_learning
- https://en.wikipedia.org/wiki/Mathematical_optimization
- https://en.wikipedia.org/wiki/Maxima_and_minima
- https://en.wikipedia.org/wiki/Unintended_consequences
- https://en.wikipedia.org/wiki/Confounding
- https://en.wikipedia.org/wiki/Correlation_does_not_imply_causation
- https://en.wikipedia.org/wiki/Multiple-criteria_decision_analysis
- https://en.wikipedia.org/wiki/Code_coverage
- https://en.wikipedia.org/wiki/Conditional_independence
- https://en.wikipedia.org/wiki/SMART_criteria
- https://westurner.org/opengov/un/#un-sustainable-development-goals
- https://en.wikipedia.org/wiki/Sustainable_Development_Goals
- http://www.globalgoals.org/


.. author:: default
.. categories:: none
.. tags:: TDD, TST, Testing, Success, Planning, Goals
.. comments::
