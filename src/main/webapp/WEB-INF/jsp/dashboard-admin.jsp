<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="header.jsp" %>

<div class="page-header">
    <div class="container">
        <h1>⚙️ Admin Command Center</h1>
        <p>System overview for ${sessionScope.userName}.</p>
    </div>
</div>

<div class="container py-4">
    <div class="row g-4 mb-5">
        <div class="col-md-3"><div class="stat-card"><div class="stat-value">${totalAgents}</div><div class="stat-label">Total Agents</div></div></div>
        <div class="col-md-3"><div class="stat-card"><div class="stat-value">${totalClients}</div><div class="stat-label">Total Clients</div></div></div>
        <div class="col-md-3"><div class="stat-card"><div class="stat-value">${totalProperties}</div><div class="stat-label">Properties</div></div></div>
        <div class="col-md-3"><div class="stat-card"><div class="stat-value">${totalAppointments}</div><div class="stat-label">Appointments</div></div></div>
    </div>

    <h4 class="mb-3" style="font-weight: 700;">Quick Actions</h4>
    <div class="row g-4">
        <div class="col-md-3"><div class="module-card text-center"><div class="module-card-icon mx-auto">🤝</div><h5 class="module-card-title">Manage Agents</h5><a href="/agents/list" class="btn btn-primary w-100 mt-3">View</a></div></div>
        <div class="col-md-3"><div class="module-card text-center"><div class="module-card-icon mx-auto">👤</div><h5 class="module-card-title">Manage Clients</h5><a href="/clients/list" class="btn btn-primary w-100 mt-3">View</a></div></div>
        <div class="col-md-3"><div class="module-card text-center"><div class="module-card-icon mx-auto">🏘️</div><h5 class="module-card-title">Properties</h5><a href="/properties/list" class="btn btn-primary w-100 mt-3">View</a></div></div>
        <div class="col-md-3"><div class="module-card text-center"><div class="module-card-icon mx-auto">⚙️</div><h5 class="module-card-title">Admins</h5><a href="/admins/list" class="btn btn-primary w-100 mt-3">View</a></div></div>
    </div>
</div>

<%@ include file="footer.jsp" %>