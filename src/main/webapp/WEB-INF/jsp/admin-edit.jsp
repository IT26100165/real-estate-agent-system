<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="header.jsp" %>

<div class="container" style="max-width: 650px;">
    <h2 class="page-title">✏️ Edit Admin</h2>

    <div class="form-card fade-in">
        <form action="/admins/edit" method="post">
            <div class="mb-3">
                <label class="form-label">Admin ID (read only)</label>
                <input type="text" name="id" class="form-control" value="${admin.id}" readonly>
            </div>
            <div class="mb-3">
                <label class="form-label">Full Name</label>
                <input type="text" name="name" class="form-control" value="${admin.name}" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Email</label>
                <input type="email" name="email" class="form-control" value="${admin.email}" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Password</label>
                <input type="text" name="password" class="form-control" value="${admin.password}" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Permissions</label>
                <select name="permissions" class="form-select">
                    <option value="FULL_ACCESS" ${admin.permissions == 'FULL_ACCESS' ? 'selected' : ''}>FULL_ACCESS</option>
                    <option value="READ_ONLY" ${admin.permissions == 'READ_ONLY' ? 'selected' : ''}>READ_ONLY</option>
                </select>
            </div>
            <div class="mb-3">
                <label class="form-label">Last Login</label>
                <input type="text" name="lastLogin" class="form-control" value="${admin.lastLogin}" readonly>
            </div>
            <div class="mb-3">
                <label class="form-label">Activity Log</label>
                <input type="text" name="activityLog" class="form-control" value="${admin.activityLog}">
            </div>

            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-success">💾 Save Changes</button>
                <a href="/admins/list" class="btn btn-outline-primary">Cancel</a>
            </div>
        </form>
    </div>
</div>

<%@ include file="footer.jsp" %>