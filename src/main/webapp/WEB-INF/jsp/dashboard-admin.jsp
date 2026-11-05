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

    <div class="row g-4">
        <!-- Chart Column -->
        <div class="col-md-5">
            <div class="module-card h-100 p-4">
                <h5 class="fw-bold mb-4">System Distribution</h5>
                <div style="position: relative; height:300px; width:100%; display: flex; justify-content: center;">
                    <canvas id="adminChart"></canvas>
                </div>
            </div>
        </div>

        <!-- Quick Actions Column -->
        <div class="col-md-7">
            <h5 class="fw-bold mb-3">Quick Actions</h5>
            <div class="row g-4">
                <div class="col-md-6">
                    <div class="module-card text-center p-3">
                        <div class="module-card-icon mx-auto"><i class="bi bi-people-fill"></i></div>
                        <h6 class="fw-bold mt-2">Agents</h6>
                        <a href="/agents/list" class="btn btn-outline-primary w-100 mt-2">Manage</a>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="module-card text-center p-3">
                        <div class="module-card-icon mx-auto"><i class="bi bi-person-badge-fill"></i></div>
                        <h6 class="fw-bold mt-2">Clients</h6>
                        <a href="/clients/list" class="btn btn-outline-primary w-100 mt-2">Manage</a>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="module-card text-center p-3">
                        <div class="module-card-icon mx-auto"><i class="bi bi-house-fill"></i></div>
                        <h6 class="fw-bold mt-2">Properties</h6>
                        <a href="/properties/list" class="btn btn-outline-primary w-100 mt-2">Manage</a>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="module-card text-center p-3">
                        <div class="module-card-icon mx-auto"><i class="bi bi-shield-fill"></i></div>
                        <h6 class="fw-bold mt-2">Admins</h6>
                        <a href="/admins/list" class="btn btn-outline-primary w-100 mt-2">Manage</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        const ctx = document.getElementById('adminChart').getContext('2d');
        new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: ['Agents', 'Clients', 'Properties', 'Appointments'],
                datasets: [{
                    data: [${totalAgents}, ${totalClients}, ${totalProperties}, ${totalAppointments}],
                    backgroundColor: ['#4f46e5', '#059669', '#9333ea', '#ea580c'],
                    borderWidth: 0,
                    hoverOffset: 4
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                cutout: '70%',
                plugins: {
                    legend: { position: 'bottom', labels: { usePointStyle: true, padding: 20 } }
                }
            }
        });
    });
</script>

<%@ include file="footer.jsp" %>