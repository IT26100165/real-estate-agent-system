<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="header.jsp" %>

<div class="page-header pb-3">
    <div class="container">
        <h1 class="fw-bold"><i class="bi bi-house-heart text-primary me-2"></i>Client Hub</h1>
        <p class="text-muted">Welcome back, ${sessionScope.userName}. Ready to find your dream home?</p>
    </div>
</div>

<div class="container py-4">
    <!-- Stats Row -->
    <div class="row g-4 mb-5">
        <div class="col-md-6">
            <div class="stat-card-new h-100">
                <div class="stat-icon stat-icon-orange"><i class="bi bi-calendar-check"></i></div>
                <div class="stat-content">
                    <div class="stat-number">${myAppointments}</div>
                    <div class="stat-label">My Booked Appointments</div>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="stat-card-new h-100">
                <div class="stat-icon stat-icon-purple"><i class="bi bi-star"></i></div>
                <div class="stat-content">
                    <div class="stat-number">${myReviews}</div>
                    <div class="stat-label">Reviews I've Written</div>
                </div>
            </div>
        </div>
    </div>

    <!-- Quick Actions -->
    <h4 class="mb-3 fw-bold">Find Your Next Home</h4>
    <div class="row g-4">
        <div class="col-md-4">
            <div class="module-card h-100 p-4 text-center">
                <div class="module-card-icon mx-auto"><i class="bi bi-people-fill"></i></div>
                <h5 class="fw-bold mt-3">Find an Agent</h5>
                <p class="text-muted small mb-4">Browse top-rated real estate professionals in your area.</p>
                <a href="/agents/list" class="btn btn-primary w-100 mt-auto">Browse Agents</a>
            </div>
        </div>

        <div class="col-md-4">
            <div class="module-card h-100 p-4 text-center">
                <div class="module-card-icon mx-auto"><i class="bi bi-house-door-fill"></i></div>
                <h5 class="fw-bold mt-3">Browse Properties</h5>
                <p class="text-muted small mb-4">Search listings by location, price range, and property type.</p>
                <a href="/properties/list" class="btn btn-outline-primary w-100 mt-auto">View Properties</a>
            </div>
        </div>

        <div class="col-md-4">
            <div class="module-card h-100 p-4 text-center">
                <div class="module-card-icon mx-auto"><i class="bi bi-calendar-plus-fill"></i></div>
                <h5 class="fw-bold mt-3">Book a Viewing</h5>
                <p class="text-muted small mb-4">Schedule an appointment to view a property with an agent.</p>
                <a href="/appointments/add" class="btn btn-outline-primary w-100 mt-auto">Book Now</a>
            </div>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>