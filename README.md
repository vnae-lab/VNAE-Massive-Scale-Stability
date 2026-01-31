# VNAE-Massive-Scale-Stability 
**High-Dimensional Asymmetric Multi-Agent Dynamics**

## Overview
This repository presents a **large-scale validation of asymmetric stability** under the **Victoria–Nash Asymmetric Equilibrium (VNAE)** framework. By simulating a system with **10,000 heterogeneous agents** on a sparse directed network, we demonstrate that global contraction and structural stability persist at scale, even under persistent external perturbations.

The objective is not optimization or equilibrium computation, but **structural validation of geometric stability** in high-dimensional asymmetric systems.

## Model
Each agent is described by a scalar state $\omega_{i}(t)$, evolving according to the gradient flow:

dω/dt = − L · ω − Θ · ω + p

Where:

ω ∈ R^n
Vector of agent states (e.g., liquidity stress)

L
Directed network Laplacian representing agent exposure

Θ = diag(θ1, θ2, ..., θn)
Matrix encoding heterogeneous asymmetric dissipation

p ∈ R^n
Persistent external forcing (exogenous stress or funding pressure)




## Effective Geometry (VNAE)
The stability is certified by an effective quadratic geometry:
g = I + β · (Θ + A)

where:

I = identity matrix
β > 0  (geometric rigidity parameter)


A scalar curvature proxy **K** is estimated statistically from heterogeneity and connectivity. In addition, a positive K (K>0) indicates structural contraction induced by asymmetric dissipation, confirming the existence of a stable invariant manifold. 

This is not a full Riemannian metric, but an effective geometric proxy consistent with the VNAE framework.

## Key Results (10,000 Agents)
Our simulations confirm that VNAE-induced stability scales beyond low-dimensional "toy models".

| Metric | Result | Interpretation |
| :--- | :--- | :--- |
| **Agents (n)** | 10,000 | National-scale financial/AI system simulation. |
| **Curvature (K)** | 0.002128 | Confirms the existence of a stable invariant manifold. |
| **Network Density** | 0.000999 | Stability maintained even with very low connectivity. |
| **Status** | **Stable** | Geometrically Certified (VNAE) when K > 0. |

### Interpretation of the Dynamics
The visualization displays trajectories of a random subset of agents evolving over time.
* **Contraction**: Despite strong heterogeneity and external forcing, all trajectories rapidly contract toward a narrow neighborhood around the equilibrium manifold.
* **Late-time Spread**: The apparent "spread" reflects residual heterogeneous modes, not instability.
* **Volume Contraction**: At large scale, exact pointwise convergence is neither expected nor required; volume contraction is the relevant stability notion.



## But... Why This Is Not a Toy Model

Below, we can present some of the reasons:

* **Massive Scale**: 10,000 agents representing a full interbank or multi-agent AI network.
* **Sparse Directed Network**: Realistic connectivity patterns.
* **High Heterogeneity**: Parameters are intentionally diverse to avoid fine-tuned balance.
* **Structural Verification**: Stability is verified by the underlying geometry, not by tuning.

## Implementation Notes
* **Performance**: Sparse matrix representations and vectorized operations are used to ensure computational feasibility at large scale.
* **Visualization**: Only a subset of trajectories is plotted for readability; all 10,000 agents are included in the computation.

## Reference

## License
MIT License
