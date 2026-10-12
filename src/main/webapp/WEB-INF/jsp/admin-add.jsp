<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="header.jsp" %>

<div class="container" style="max-width: 650px;">
    <h2 class="page-title">➕ Register New Admin</h2>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <div class="form-card fade-in">
        <form action="/admins/add" method="post">
            <div class="mb-3">
                <label class="form-label">Admin ID</label>
                <input type="text" name="id" class="form-control" placeholder="ADM-9001" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Full Name</label>
                <input type="text" name="name" class="form-control" placeholder="Admin Name" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Email</label>
                <input type="email" name="email" class="form-control" placeholder="admin@system.com" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Password</label>
                <input type="password" name="password" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Permissions</label>
                <select name="permissions" class="form-select">
                    <option value="FULL_ACCESS">FULL_ACCESS</option>
                    <option value="READ_ONLY">READ_ONLY</option>
                </select>
            </div>
            <div class="mb-3">
                <label class="form-label">Activity Log</label>
                <input type="text" name="activityLog" class="form-control"
                       placeholder="e.g., Created account" value="Account created">
            </div>

            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-success">💾 Save Admin</button>
                <a href="/admins/list" class="btn btn-outline-primary">Cancel</a>
            </div>
        </form>
    </div>
</div>

<%@ include file="footer.jsp" %>