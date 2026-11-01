<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="header.jsp" %>

<div class="container py-5" style="max-width: 650px;">
    <h2 class="page-title mb-4"><i class="bi bi-person-gear text-primary me-2"></i>My Profile</h2>

    <div class="form-card">
        <div class="d-flex align-items-center mb-4 pb-3 border-bottom">
            <div class="user-avatar me-3" style="width: 60px; height: 60px; font-size: 1.5rem; background: #e0e7ff; color: #4f46e5;">
                ${fn:substring(profile.name, 0, 1)}
            </div>
            <div>
                <h4 class="mb-0 fw-bold">${profile.name}</h4>
                <span class="badge bg-primary-subtle text-primary border border-primary-subtle rounded-pill px-2 mt-1">
                    ${sessionScope.role} Account
                </span>
            </div>
        </div>

        <form action="/profile" method="post">
            <div class="mb-3">
                <label class="form-label">User ID (Read-Only)</label>
                <input type="text" class="form-control bg-light" value="${profile.id}" readonly>
            </div>
            <div class="mb-3">
                <label class="form-label">Full Name</label>
                <input type="text" name="name" class="form-control" value="${profile.name}" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Email Address</label>
                <input type="email" name="email" class="form-control" value="${profile.email}" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Password</label>
                <input type="text" name="password" class="form-control" value="${profile.password}" required>
                <small class="text-muted">Keep this secure. You will use it for your next login.</small>
            </div>

            <div class="d-flex gap-2 mt-4">
                <button type="submit" class="btn btn-success"><i class="bi bi-save me-1"></i> Save Changes</button>
                <a href="/dashboard" class="btn btn-outline-primary">Back to Dashboard</a>
            </div>
        </form>
    </div>
</div>

<%@ include file="footer.jsp" %>