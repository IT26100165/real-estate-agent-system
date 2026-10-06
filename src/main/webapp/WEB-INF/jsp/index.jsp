<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="header.jsp" %>

<!-- HERO SECTION -->
<div class="hero fade-in">
    <h1>Find Your Perfect Agent</h1>
    <p>Connect with trusted real estate professionals. Book appointments. Find your dream property.</p>
    <a href="/agents/list" class="btn btn-hero">Browse Agents →</a>
</div>

<!-- MODULES SECTION -->
<h2 class="page-title text-center justify-content-center mb-4">✨ Everything You Need</h2>

<div class="row g-4">
    <div class="col-md-4">
        <div class="card card-modern fade-in">
            <div class="card-body text-center p-4">
                <span class="card-icon">🤝</span>
                <h5 class="card-title">Agent Management</h5>
                <p class="card-text">Register and manage top real estate agents with intelligent search and rating-based rankings.</p>
                <a href="/agents/list" class="btn btn-primary">View Agents</a>
            </div>
        </div>
    </div>

    <div class="col-md-4">
        <div class="card card-modern fade-in">
            <div class="card-body text-center p-4">
                <span class="card-icon">👤</span>
                <h5 class="card-title">Client Management</h5>
                <p class="card-text">Register clients, manage profiles, and maintain complete account information securely.</p>
                <a href="/clients/list" class="btn btn-outline-primary">View Clients</a>
            </div>
        </div>
    </div>

    <div class="col-md-4">
        <div class="card card-modern fade-in">
            <div class="card-body text-center p-4">
                <span class="card-icon">📅</span>
                <h5 class="card-title">Appointments</h5>
                <p class="card-text">Book, reschedule, and manage appointments between clients and agents effortlessly.</p>
                <a href="/appointments/list" class="btn btn-outline-primary">View Appointments</a>
            </div>
        </div>
    </div>

    <div class="col-md-4">
        <div class="card card-modern fade-in">
            <div class="card-body text-center p-4">
                <span class="card-icon">🏘️</span>
                <h5 class="card-title">Property Listings</h5>
                <p class="card-text">Browse properties by location, price, and type. Find the perfect match for every client.</p>
                <a href="/properties/list" class="btn btn-outline-primary">View Properties</a>
            </div>
        </div>
    </div>

    <div class="col-md-4">
        <div class="card card-modern fade-in">
            <div class="card-body text-center p-4">
                <span class="card-icon">⭐</span>
                <h5 class="card-title">Reviews & Ratings</h5>
                <p class="card-text">Submit honest feedback and view ratings from other clients to make informed decisions.</p>
                <a href="/reviews/list" class="btn btn-outline-primary">View Reviews</a>
            </div>
        </div>
    </div>

    <div class="col-md-4">
        <div class="card card-modern fade-in">
            <div class="card-body text-center p-4">
                <span class="card-icon">⚙️</span>
                <h5 class="card-title">Admin Panel</h5>
                <p class="card-text">Complete control over administrators, permissions, and system-wide access management.</p>
                <a href="/admins/list" class="btn btn-outline-primary">View Admins</a>
            </div>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>