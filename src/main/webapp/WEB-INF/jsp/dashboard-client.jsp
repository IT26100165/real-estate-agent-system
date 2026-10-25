<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="header.jsp" %>

<div class="page-header">
    <div class="container">
        <h1>🏠 Client Hub</h1>
        <p>Welcome back, ${sessionScope.userName}. Ready to find your dream home?</p>
    </div>
</div>

<div class="container py-4">
    <div class="row g-4 mb-5">
        <div class="col-md-6"><div class="stat-card"><div class="stat-value">${myAppointments}</div><div class="stat-label">My Booked Appointments</div></div></div>
        <div class="col-md-6"><div class="stat-card"><div class="stat-value">${myReviews}</div><div class="stat-label">Reviews I've Written</div></div></div>
    </div>

    <h4 class="mb-3" style="font-weight: 700;">Find Your Next Home</h4>
    <div class="row g-4">
        <div class="col-md-4"><div class="module-card"><div class="module-card-icon">🤝</div><h5 class="module-card-title">Find an Agent</h5><p class="module-card-text">Browse top-rated professionals.</p><a href="/agents/list" class="btn btn-primary">Browse Agents</a></div></div>
        <div class="col-md-4"><div class="module-card"><div class="module-card-icon">🏘️</div><h5 class="module-card-title">Browse Properties</h5><p class="module-card-text">Search listings by location and price.</p><a href="/properties/list" class="btn btn-outline-primary">View Properties</a></div></div>
        <div class="col-md-4"><div class="module-card"><div class="module-card-icon">📅</div><h5 class="module-card-title">Book Appointment</h5><p class="module-card-text">Schedule a viewing with an agent.</p><a href="/appointments/add" class="btn btn-outline-primary">Book Now</a></div></div>
    </div>
</div>

<%@ include file="footer.jsp" %>