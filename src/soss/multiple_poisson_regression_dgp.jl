using Distributions

function multiple_poisson_dgp(RNG, N, mean_traps)
    log_sq_foot = Vector{Float64}(undef, N)  # Use zeros?
    live_in_super = Vector{Float64}(undef, N)  # Use zeros?
    traps = Vector{Int64}(undef, N)  # Use zeros?
    complaints = Vector{Int64}(undef, N)  # Use zeros?

    α = rand(RNG, Normal(log(4), .1))
    β = rand(RNG, Normal(-0.25, .1))
    β_super = rand(RNG, Normal(-0.5, 1))

    for i in 1:N
        log_sq_foot[i] = rand(RNG, Normal(1.5, 0.1))
        live_in_super[i] = rand(RNG, Bernoulli(0.5))
        traps[i] = rand(RNG, Poisson(8))
        λ = exp(α + log_sq_foot[i] + β * traps[i] + β_super * live_in_super[i])
        complaints[i] = rand(RNG, Poisson(λ))
    end

    return (α = α,
            β = β,
            β_super = β_super,
            log_sq_foot = log_sq_foot,
            live_in_super = live_in_super,
            traps = traps,
            complaints = complaints)
end
