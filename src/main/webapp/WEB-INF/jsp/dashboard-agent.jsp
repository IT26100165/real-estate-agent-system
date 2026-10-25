<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="header.jsp" %>

<div class="page-header">
    <div class="container">
        <h1>💼 Agent Workspace</h1>
        <p>Welcome back, ${sessionScope.userName}. Here is your performance overview.</p>
    </div>
</div>

<div class="container py-4">
    <div class="row g-4 mb-5">
        <div class="col-md-3"><div class="stat-card"><div class="stat-value">${myProperties}</div><div class="stat-label">My Listings</div></div></div>
        <div class="col-md-3"><div class="stat-card"><div class="stat-value">${myAppointments}</div><div class="stat-label">Appointments</div></div></div>
        <div class="col-md-3"><div class="stat-card"><div class="stat-value">${myReviews}</div><div class="stat-label">Total Reviews</div></div></div>
        <div class="col-md-3"><div class="stat-card"><div class="stat-value">⭐ ${myRating}</div><div class="stat-label">Average Rating</div></div></div>
    </div>

    <h4 class="mb-3" style="font-weight: 700;">My Workspace</h4>
    <div class="row g-4">
        <div class="col-md-4"><div class="module-card"><div class="module-card-icon">🏘️</div><h5 class="module-card-title">My Properties</h5><p class="module-card-text">Manage your active listings.</p><a href="/properties/list" class="btn btn-outline-primary">Manage Listings</a></div></div>
        <div class="col-md-4"><div class="module-card"><div class="module-card-icon">📅</div><h5 class="module-card-title">My Schedule</h5><p class="module-card-text">View upcoming client appointments.</p><a href="/appointments/list" class="btn btn-outline-primary">View Schedule</a></div></div>
        <div class="col-md-4"><div class="module-card"><div class="module-card-icon">⭐</div><h5 class="module-card-title">My Reviews</h5><p class="module-card-text">See what clients are saying about you.</p><a href="/reviews/list" class="btn btn-outline-primary">View Reviews</a></div></div>
    </div>
</div>

<%@ include file="footer.jsp" %>