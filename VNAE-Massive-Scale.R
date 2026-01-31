# -------------------------------------------------------------------------
# VNAE Framework: Massive Multi-Agent System (n=10,000)
# Purpose: High-Dimensional Stability Validation & Curvature Analysis
# -------------------------------------------------------------------------

rm(list = ls())
library(deSolve)
library(Matrix) # Required for efficient large-scale matrix operations

# --- [ USER CONTROL PANEL ] ---

n <- 10000              # 10,000 Agents (Large Scale Multi-Agent System)
beta_val <- 0.25        # Geometric Rigidity (VNAE Strength)

# 1. GENERATE ASYMMETRIC FRICTIONS (THETA)
# Using a distribution to represent high-dimensional heterogeneity
theta_agents <- runif(n, min = 0.5, max = 15.0) 
Theta_mat <- Diagonal(x = theta_agents)

# 2. GENERATE SPARSE EXPOSURE NETWORK (A)
# At n=10,000, we use a Sparse Matrix to save memory.
# We simulate a "Scale-Free" style density.
nz_count <- n * 10      # Each agent connects to ~10 others on average
i_idx <- sample(1:n, nz_count, replace = TRUE)
j_idx <- sample(1:n, nz_count, replace = TRUE)
values <- rexp(nz_count, rate = 1)

A_sparse <- sparseMatrix(i = i_idx, j = j_idx, x = values, dims = c(n, n))
diag(A_sparse) <- 0

# 3. INITIAL LIQUIDITY STRESS (OMEGA)
omega_init <- rnorm(n, mean = 0, sd = 1)

# -------------------------------------------------------------------------
# VNAE CORE MATHEMATICS (VECTORIZED)
# -------------------------------------------------------------------------

# Directed Laplacian: L = D - A
row_sums <- rowSums(A_sparse)
L_sparse <- Diagonal(x = row_sums) - A_sparse

# External Shock Vector
p_shock <- rnorm(n, 0, 0.2)

# Flow Dynamics Function (Optimized for Sparse Matrices)
vnae_flow <- function(t, omega, parms) {
  # The equation: d_omega = -(L + Theta) * omega + p
  # Matrix-vector multiplication is highly efficient here
  d_omega <- -(L_sparse %*% omega) - (theta_agents * omega) + p_shock
  return(list(as.vector(d_omega)))
}

# Numerical Simulation (Reduced time steps for 10k agents efficiency)
time_seq <- seq(0, 20, by = 0.5)
solution <- ode(y = omega_init, times = time_seq, func = vnae_flow, parms = NULL, method = "euler")

# -------------------------------------------------------------------------
# VECTORIZED CURVATURE CALCULATION (K)
# -------------------------------------------------------------------------
# Instead of loops, we use statistical sampling of the manifold
# to estimate K for n=10,000 (Central Limit Theorem approach)
sample_size <- 50000
idx_i <- sample(1:n, sample_size, replace = TRUE)
idx_j <- sample(1:n, sample_size, replace = TRUE)

diff_theta <- abs(theta_agents[idx_i] - theta_agents[idx_j])
couplings <- A_sparse[cbind(idx_i, idx_j)] + A_sparse[cbind(idx_j, idx_i)]
rigidity <- 1 + beta_val * (theta_agents[idx_i] + theta_agents[idx_j])

# Curvature estimate
K_estimate <- mean((diff_theta * couplings) / rigidity, na.rm = TRUE)

# -------------------------------------------------------------------------
# REPORT & VISUALIZATION
# -------------------------------------------------------------------------

cat("\n--- VNAE MASSIVE SCALE REPORT ---\n")
cat("Total Agents (n):", n, "\n")
cat("Network Density:", length(A_sparse@x) / (n^2), "\n")
cat("Estimated Curvature (K):", round(K_estimate, 8), "\n")
cat("Status:", if(K_estimate > 0) "Curved Manifold (Stable)" else "Flat Nash Limit", "\n")

# Visualization: We plot a random sample of 100 agents to keep the plot readable
# but the underlying math considers all 10,000.
sample_plot_idx <- sample(2:(n+1), 100)
colors <- rainbow(100, alpha = 0.2)

matplot(solution[, 1], solution[, sample_plot_idx], type = "l", lty = 1, col = colors,
        xlab = "Time Flow (t)", ylab = "Liquidity Stress (ω)",
        main = paste("VNAE: 10k Agents Manifold Flow (K =", round(K_estimate, 6), ")"))
grid()
