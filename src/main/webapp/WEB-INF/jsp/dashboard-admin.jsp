<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="header.jsp" %>

<div class="page-header pb-3">
    <div class="container">
        <h1 class="fw-bold"><i class="bi bi-shield-lock text-primary me-2"></i>Admin Command Center</h1>
        <p class="text-muted">System overview for ${sessionScope.userName}.</p>
    </div>
</div>

<div class="container py-4">
    <!-- Stats Row -->
    <div class="row g-4 mb-5">
        <div class="col-md-3">
            <div class="stat-card-new">
                <div class="stat-icon stat-icon-blue"><i class="bi bi-people"></i></div>
                <div class="stat-content">
                    <div class="stat-number">${totalAgents}</div>
                    <div class="stat-label">Total Agents</div>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stat-card-new">
                <div class="stat-icon stat-icon-green"><i class="bi bi-person-badge"></i></div>
                <div class="stat-content">
                    <div class="stat-number">${totalClients}</div>
                    <div class="stat-label">Total Clients</div>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stat-card-new">
                <div class="stat-icon stat-icon-purple"><i class="bi bi-house-door"></i></div>
                <div class="stat-content">
                    <div class="stat-number">${totalProperties}</div>
                    <div class="stat-label">Properties</div>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stat-card-new">
                <div class="stat-icon stat-icon-orange"><i class="bi bi-calendar-event"></i></div>
                <div class="stat-content">
                    <div class="stat-number">${totalAppointments}</div>
                    <div class="stat-label">Appointments</div>
                </div>
            </div>
        </div>
    </div>

    <h4 class="mb-3 fw-bold">Quick Actions</h4>
    <div class="row g-4">
        <div class="col-md-3"><div class="module-card text-center"><div class="module-card-icon mx-auto"><i class="bi bi-people-fill"></i></div><h5 class="fw-bold mt-3">Agents</h5><a href="/agents/list" class="btn btn-primary w-100 mt-3">Manage</a></div></div>
        <div class="col-md-3"><div class="module-card text-center"><div class="module-card-icon mx-auto"><i class="bi bi-person-badge-fill"></i></div><h5 class="fw-bold mt-3">Clients</h5><a href="/clients/list" class="btn btn-primary w-100 mt-3">Manage</a></div></div>
        <div class="col-md-3"><div class="module-card text-center"><div class="module-card-icon mx-auto"><i class="bi bi-house-fill"></i></div><h5 class="fw-bold mt-3">Properties</h5><a href="/properties/list" class="btn btn-primary w-100 mt-3">Manage</a></div></div>
        <div class="col-md-3"><div class="module-card text-center"><div class="module-card-icon mx-auto"><i class="bi bi-shield-fill"></i></div><h5 class="fw-bold mt-3">Admins</h5><a href="/admins/list" class="btn btn-primary w-100 mt-3">Manage</a></div></div>
    </div>
</div>

<%@ include file="footer.jsp" %>