# VNAE Massive-Scale Stability
**High-Dimensional Asymmetric Multi-Agent Dynamics**

## Overview
This repository presents a **large-scale validation of asymmetric stability** under the **Victoria-Nash Asymmetric Equilibrium (VNAE)** framework. By simulating a system with **10,000 heterogeneous agents** on a sparse directed network, we demonstrate that global contraction and structural stability persist at scale, even under persistent external perturbations.

The objective is not optimization or equilibrium computation, but **structural validation of geometric stability** in high-dimensional asymmetric systems.

## Model
Each agent is described by a scalar state ωᵢ(t), evolving according to the gradient flow:

dω/dt = − L · ω − Θ · ω + p

Where:

 ω∈ℝⁿ is the vector of agent states
 L is the directed network Laplacian
 Θ = diag(θ₁, …, θₙ) encodes heterogeneous asymmetric dissipation
 p represents persistent external forcing.

All parameters are intentionally heterogeneous to avoid symmetry or fine-tuned balance.


## Effective Geometry (VNAE)
The stability is certified by an effective quadratic geometry:
g = I + β · (Θ + A)

where:

I = identity matrix
β > 0  (geometric rigidity parameter)


A scalar curvature proxy **K** is estimated statistically from heterogeneity and connectivity. In addition, a positive K (K>0) indicates structural contraction induced by asymmetric dissipation, confirming the existence of a stable invariant manifold. 

This is not a full Riemannian metric, but an effective geometric proxy consistent with the VNAE framework.


## Curvature Proxy (Scalable Estimation)

To assess global stability at scale, a statistical curvature proxy is computed:

K = E [ |θ_i − θ_j| · |A_ij| / (1 + β (θ_i + θ_j)) ]


Estimated via Monte Carlo sampling

(i, j) ~ Uniform({1,...,n} × {1,...,n})


## Interpretation of the Plot

Only a random subset of agents is visualized for clarity:

N = 100 agents

### Key observations

* All trajectories rapidly contract toward a narrow band.
* No exponential growth or oscillatory divergence occurs.
* Late-time dispersion reflects:

  * heterogeneous dissipation rates
  * numerical integration noise
  * sparse directed coupling

### Important

Pointwise convergence is NOT required. Volume contraction IS the stability criterion.

The system stabilizes without synchronization.


### Interpretation

* ( K > 0 )  → positively curved effective manifold
* positive curvature → volume contraction
* volume contraction → global stability


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
* **Visualization**: Only a subset (n  = 100) of trajectories is plotted for readability; all 10,000 agents are included in the computation.

## Reference

Pereira, D. H. (2025). Riemannian Manifolds of Asymmetric Equilibria: The Victoria-Nash Geometry.

## License
MIT License
