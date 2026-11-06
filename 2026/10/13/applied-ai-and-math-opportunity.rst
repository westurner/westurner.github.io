Applied AI and Math opportunity
===============================

There are so many headlines about AI and math lately;

The media is selling ads on articles about how AI is cannibalizing research math,
and it's all over for them, the mathematicians.

I've been doing math and lately AI math with Lean 4 and Mathlib and Physlib and QECLean
and other tests to validate and verify
various questions typically first about applied physics and then about the support.

Where are the feasibility gaps in this design?

What is the current limit to the LLM as a simulator?
With which model, model parameters, agent, agent harness?

How many prompts will it take to build a simulator for this,
and then how to compare simulator models?
With grid search and cross-validation?

Is there work to do in research math?

There is still a lot of work to do in applied math and applied physics
given an understanding of margin, the accounting equation, and business calculus.

Are there new math problems yet?

I guess we'll have to go find some new math problems.

Usually, when there are breakthroughs in math and science,
it takes some time for the community to validate the findings
and then it takes even longer for the information diffusion or tech diffusion
to happen.

So can someone explain what this all means,
in terms of math and careers for mathematicians and journalists and AI?

To validate math and science and physics research takes time you know.

When they did computers and then the internet,
there were a lot of articles about it too,
FWIU (From What I Understand).

Will the pocket calculator ruin mathematics and mathematicians forever?

Will the internet be the death knell for libraries and research assistants?

What about journals that host PDFs and comments? What will AI do there?

It is much easier for an agent to work with the `.tex` version of an article than the PDF
because PDF to plaintext is so lossy:
try and copy and paste LaTeX from a PDF into a notebook or a prompt interface.

So for now we see through a glass darkly,
without the ability to interpret for example
the 3d diagrams of this "Layer Coding" paper
which I found years ago
and reshared and linked to
and have recently started on completing a lean4 implementation of.

But can I check whether what we had the AI do there is any good?

How do I validate whether the collection of axioms and relations
we've AI amassed is a coherent, cohesive, rational logical argument
of propositions precedent to P in "if P then Q"?

Before I request community review, how much AI review should we do?

Does that the lean compiles validate a theory?

In physics,
only iff it corresponds to real observations from qualifying experimentation
can a theory be validated in physics.

An example:

We've generated a number of draft simulators in the westurner/particlewavefluid project
with no version number on anything. There's no v1.0.0 release of this project.
`WaveInterferenceSim` is one of the simulators in the westurner/particlewavefluid project.
We prompted sufficiently to generate a simple wave interference simulator
that models classical Constructive Interference of waves as particles
(with ThreeJS and ReactThreeFiber),
and then added an EM Tensor Gaussian wave model,
and then added quantum Superposition of waves,
and then added a detector screen to do Young's Experiment and the Double-Slit Experiment,
and then added multiple implementations of superposition,
and then added rudimentary model scoring and ranking.

We prompted the agent to implement these models of superposition of photons and electrons:

- Intensity (per Huygens-Steiner (per "Bridging coherence optics and classical mechanics: A generic light polarization-entanglement complementary relation" (2023)) )
- Pilot Wave theory
- Wigner function
- Wigner function (GPU)

From here it looks like Intensity is the better model for superposition of photons and electrons
because it's faster in simulation,
but we haven't done any actual experiment at all to confirm or reject our prediction about the frequency of photonic ocurrence on a detector screen;
we've only done simulation on the computer
and that alone is not sufficient to validate our finding
because to validate a model in physics,
it must be proven by experimentation with the scientific method.

So, now, biased with background information from informal experiment,
go do the lab experiment design to check whether
the pattern on the detector screen that we simulate with our rudimentary simulator
is the same pattern that we observe in another controlled experiment with double-slit interference.

Or, is it enough to go pull the data from existing experiments?
We're talking about a 2d distribution of pixels;
how hard is it to resuse data from existing experiments?

So all we've done is score the error between the models and manually fiddle with parameters.

I haven't validated a valid scientific theory,
I've shared findings early because open science is less trouble.

If Intensity is a sufficient model for photonic and electronic superposition,
then Pilot Wave Theory and Wigner Function are wrong.
Given that I'm an amateur in the field, that's unlikely.

Though, through manual parameter search of detector screen 'Glow Time' parameters
we found an 8.1% relative difference between
Pilot Wave Theory and Classical Intensity.

To really answer which is more correct (probably decades-accepted Pilot Wave Theory)
we need to have real data from real experiments,
and there's only so much that a Lean derivation can prove.

***

I am not dismayed at the recent increase in publishing rate in AI math.

There is still work to do.

Do we need to adapt to new AI tools; just like computers and the internet?

How will writing an article about applied AI and math opportunity get work done?


.. author:: default
.. categories:: none
.. tags:: ai, math, applied ai
.. comments::
