<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="header.jsp" %>

<div class="text-center py-5 bg-light rounded mb-4">
    <h1 class="display-4">Real Estate Agent Finder</h1>
    <p class="lead">Connecting clients with trusted real estate agents.</p>
    <a href="/agents/list" class="btn btn-primary btn-lg mt-2">Browse Agents</a>
</div>

<h2 class="text-center mb-4">Our Modules</h2>

<div class="row g-4">
    <div class="col-md-4">
        <div class="card h-100 shadow-sm">
            <div class="card-body text-center">
                <h5 class="card-title">🤝 Agent Management</h5>
                <p class="card-text">Register and manage real estate agents. Uses BST for fast search and Selection Sort for ranking.</p>
                <a href="/agents/list" class="btn btn-outline-primary">View Agents</a>
            </div>
        </div>
    </div>

    <div class="col-md-4">
        <div class="card h-100 shadow-sm">
            <div class="card-body text-center">
                <h5 class="card-title">👤 Client Management</h5>
                <p class="card-text">Register new clients, manage profiles, and maintain account information.</p>
                <a href="/clients/list" class="btn btn-outline-primary">View Clients</a>
            </div>
        </div>
    </div>

    <div class="col-md-4">
        <div class="card h-100 shadow-sm">
            <div class="card-body text-center">
                <h5 class="card-title">📅 Appointments</h5>
                <p class="card-text">Book and manage appointments between clients and agents.</p>
                <a href="/appointments/list" class="btn btn-outline-primary">View Appointments</a>
            </div>
        </div>
    </div>

    <div class="col-md-4">
        <div class="card h-100 shadow-sm">
            <div class="card-body text-center">
                <h5 class="card-title">🏘️ Property Listings</h5>
                <p class="card-text">Browse and manage available property listings.</p>
                <a href="/properties/list" class="btn btn-outline-primary">View Properties</a>
            </div>
        </div>
    </div>

    <div class="col-md-4">
        <div class="card h-100 shadow-sm">
            <div class="card-body text-center">
                <h5 class="card-title">⭐ Reviews & Ratings</h5>
                <p class="card-text">Submit and view feedback on agents.</p>
                <a href="/reviews/list" class="btn btn-outline-primary">View Reviews</a>
            </div>
        </div>
    </div>

    <div class="col-md-4">
        <div class="card h-100 shadow-sm">
            <div class="card-body text-center">
                <h5 class="card-title">⚙️ Admin Panel</h5>
                <p class="card-text">Manage system administrators, permissions, and access control.</p>
                <a href="/admins/list" class="btn btn-outline-primary">View Admins</a>
            </div>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>