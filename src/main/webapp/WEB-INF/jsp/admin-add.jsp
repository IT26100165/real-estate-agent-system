<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="header.jsp" %>

<div class="container py-5" style="max-width: 650px;">
    <h2 class="page-title mb-4">➕ Register New Admin</h2>
    <c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>

    <div class="form-card">
        <form action="/admins/add" method="post">
            <div class="mb-3"><label class="form-label">Admin ID</label><input type="text" name="id" class="form-control" required></div>
            <div class="mb-3"><label class="form-label">Full Name</label><input type="text" name="name" class="form-control" required></div>
            <div class="mb-3"><label class="form-label">Email</label><input type="email" name="email" class="form-control" required></div>
            <div class="mb-3"><label class="form-label">Password</label><input type="password" name="password" class="form-control" required></div>
            <div class="mb-3">
                <label class="form-label">Permissions</label>
                <select name="permissions" class="form-select"><option value="FULL_ACCESS">FULL_ACCESS</option><option value="READ_ONLY">READ_ONLY</option></select>
            </div>
            <div class="mb-3"><label class="form-label">Activity Log</label><input type="text" name="activityLog" class="form-control" value="Account created"></div>

            <div class="d-flex gap-2 mt-4">
                <button type="submit" class="btn btn-success">💾 Save Admin</button>
                <a href="/admins/list" class="btn btn-outline-primary">Cancel</a>
            </div>
        </form>
    </div>
</div>
<%@ include file="footer.jsp" %>