<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="header.jsp" %>

<!-- PREMIUM HERO -->
<div class="hero-section text-center">
    <div class="container">
        <span class="badge bg-primary-subtle text-primary mb-3 px-3 py-2 rounded-pill border border-primary-subtle">The #1 Real Estate Platform</span>
        <h1 class="display-4 fw-bold mb-3" style="letter-spacing: -1.5px;">Find the right agent, <br><span class="text-primary">effortlessly.</span></h1>
        <p class="lead text-muted mb-5 mx-auto" style="max-width: 600px;">
            Connect with trusted real estate professionals, book appointments, and find your next property — all in one beautiful place.
        </p>
        <div class="d-flex justify-content-center gap-3">
            <a href="/agents/list" class="btn btn-primary btn-lg px-4">Browse Agents <i class="bi bi-arrow-right ms-1"></i></a>
            <a href="/login" class="btn btn-outline-primary btn-lg px-4">Sign In</a>
        </div>
    </div>
</div>

<!-- FEATURES -->
<div class="container py-5">
    <div class="text-center mb-5">
        <h2 class="fw-bold">Everything you need</h2>
        <p class="text-muted">Six integrated modules that power the entire workflow.</p>
    </div>

    <div class="row g-4">
        <div class="col-md-4">
            <div class="module-card h-100 p-4">
                <div class="module-card-icon"><i class="bi bi-people-fill"></i></div>
                <h5 class="fw-bold mb-2">Agent Directory</h5>
                <p class="text-muted small mb-4">Browse real estate agents with intelligent rating-based rankings powered by Selection Sort.</p>
                <a href="/agents/list" class="btn btn-outline-primary mt-auto">View Agents</a>
            </div>
        </div>
        <div class="col-md-4">
            <div class="module-card h-100 p-4">
                <div class="module-card-icon"><i class="bi bi-house-door-fill"></i></div>
                <h5 class="fw-bold mb-2">Property Listings</h5>
                <p class="text-muted small mb-4">Search listings by location, price, and type. Find the perfect match for every client.</p>
                <a href="/properties/list" class="btn btn-outline-primary mt-auto">View Properties</a>
            </div>
        </div>
        <div class="col-md-4">
            <div class="module-card h-100 p-4">
                <div class="module-card-icon"><i class="bi bi-shield-lock-fill"></i></div>
                <h5 class="fw-bold mb-2">Secure Access</h5>
                <p class="text-muted small mb-4">Role-based access control (RBAC) for Admins, Agents, and Clients with session management.</p>
                <a href="/login" class="btn btn-outline-primary mt-auto">Sign In</a>
            </div>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>