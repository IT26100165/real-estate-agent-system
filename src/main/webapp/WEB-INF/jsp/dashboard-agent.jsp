<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="header.jsp" %>

<div class="page-header pb-3">
    <div class="container">
        <h1 class="fw-bold"><i class="bi bi-briefcase text-primary me-2"></i>Agent Workspace</h1>
        <p class="text-muted">Welcome back, ${sessionScope.userName}. Here is your performance overview.</p>
    </div>
</div>

<div class="container py-4">
    <div class="row g-4 mb-5">
        <div class="col-md-3">
            <div class="stat-card-new">
                <div class="stat-icon stat-icon-blue"><i class="bi bi-house"></i></div>
                <div class="stat-content">
                    <div class="stat-number">${myProperties}</div>
                    <div class="stat-label">My Listings</div>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stat-card-new">
                <div class="stat-icon stat-icon-orange"><i class="bi bi-calendar-event"></i></div>
                <div class="stat-content">
                    <div class="stat-number">${myAppointments}</div>
                    <div class="stat-label">Appointments</div>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stat-card-new">
                <div class="stat-icon stat-icon-purple"><i class="bi bi-chat-left-text"></i></div>
                <div class="stat-content">
                    <div class="stat-number">${myReviews}</div>
                    <div class="stat-label">Total Reviews</div>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stat-card-new">
                <div class="stat-icon stat-icon-green"><i class="bi bi-star"></i></div>
                <div class="stat-content">
                    <div class="stat-number">${myRating}</div>
                    <div class="stat-label">Average Rating</div>
                </div>
            </div>
        </div>
    </div>

    <div class="row g-4">
        <!-- Chart Column -->
        <div class="col-md-6">
            <div class="module-card h-100 p-4">
                <h5 class="fw-bold mb-4">My Activity Overview</h5>
                <div style="position: relative; height:300px; width:100%;">
                    <canvas id="agentChart"></canvas>
                </div>
            </div>
        </div>

        <!-- Quick Actions Column -->
        <div class="col-md-6">
            <h5 class="fw-bold mb-3">My Workspace</h5>
            <div class="row g-4">
                <div class="col-md-12">
                    <div class="module-card p-3 d-flex flex-row align-items-center">
                        <div class="module-card-icon m-0 me-3"><i class="bi bi-house-door-fill"></i></div>
                        <div class="flex-grow-1">
                            <h6 class="fw-bold mb-0">Manage Listings</h6>
                            <small class="text-muted">Add or edit your properties.</small>
                        </div>
                        <a href="/properties/list" class="btn btn-outline-primary">View</a>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="module-card p-3 d-flex flex-row align-items-center">
                        <div class="module-card-icon m-0 me-3"><i class="bi bi-calendar-check-fill"></i></div>
                        <div class="flex-grow-1">
                            <h6 class="fw-bold mb-0">My Schedule</h6>
                            <small class="text-muted">View upcoming client meetings.</small>
                        </div>
                        <a href="/appointments/list" class="btn btn-outline-primary">View</a>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="module-card p-3 d-flex flex-row align-items-center">
                        <div class="module-card-icon m-0 me-3"><i class="bi bi-star-fill"></i></div>
                        <div class="flex-grow-1">
                            <h6 class="fw-bold mb-0">My Reviews</h6>
                            <small class="text-muted">See what clients are saying.</small>
                        </div>
                        <a href="/reviews/list" class="btn btn-outline-primary">View</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        const ctx = document.getElementById('agentChart').getContext('2d');
        new Chart(ctx, {
            type: 'bar',
            data: {
                labels: ['Properties', 'Appointments', 'Reviews'],
                datasets: [{
                    label: 'Total Count',
                    data: [${myProperties}, ${myAppointments}, ${myReviews}],
                    backgroundColor: ['#4f46e5', '#ea580c', '#9333ea'],
                    borderRadius: 6,
                    barThickness: 50
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: false }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: { stepSize: 1 }
                    }
                }
            }
        });
    });
</script>

<%@ include file="footer.jsp" %>