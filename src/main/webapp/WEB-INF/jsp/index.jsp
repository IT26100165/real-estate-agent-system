<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="header.jsp" %>

<div class="page-header text-center">
    <div class="container">
        <h1>Find the right agent, effortlessly.</h1>
        <p class="mb-4">Connect with trusted real estate professionals, book appointments, and find your next property.</p>
        <a href="/agents/list" class="btn btn-primary btn-lg">Browse Agents →</a>
        <a href="/login" class="btn btn-outline-primary btn-lg ms-2">Sign In</a>
    </div>
</div>

<div class="container py-5">
    <h2 class="text-center mb-4" style="font-weight: 700;">Everything you need in one platform</h2>
    <div class="row g-4">
        <div class="col-md-4">
            <div class="module-card">
                <div class="module-card-icon">🤝</div>
                <h5 class="module-card-title">Agent Directory</h5>
                <p class="module-card-text">Browse real estate agents with intelligent rating-based rankings.</p>
                <a href="/agents/list" class="btn btn-outline-primary">View Agents</a>
            </div>
        </div>
        <div class="col-md-4">
            <div class="module-card">
                <div class="module-card-icon">🏘️</div>
                <h5 class="module-card-title">Property Listings</h5>
                <p class="module-card-text">Browse properties by location, price, and type.</p>
                <a href="/properties/list" class="btn btn-outline-primary">View Properties</a>
            </div>
        </div>
        <div class="col-md-4">
            <div class="module-card">
                <div class="module-card-icon">🔒</div>
                <h5 class="module-card-title">Secure Login</h5>
                <p class="module-card-text">Role-based access for Admins, Agents, and Clients.</p>
                <a href="/login" class="btn btn-outline-primary">Sign In</a>
            </div>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>