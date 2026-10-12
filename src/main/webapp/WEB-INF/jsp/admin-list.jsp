<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h2 class="page-title mb-0">⚙️ System Administrators</h2>
    <div>
        <a href="/admins/add" class="btn btn-primary">+ Add Admin</a>
        <a href="/admins/search" class="btn btn-outline-primary">🔍 Search</a>
    </div>
</div>

<p class="text-muted mb-4">Administrators with system access privileges.</p>

<c:if test="${empty admins}">
    <div class="empty-state">
        <div class="empty-state-icon">📭</div>
        <h3>No Admins Yet</h3>
        <p class="text-muted">Add the first administrator to get started.</p>
        <a href="/admins/add" class="btn btn-primary">+ Add First Admin</a>
    </div>
</c:if>

<c:if test="${not empty admins}">
    <div class="table-responsive">
        <table class="table table-modern">
            <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Permissions</th>
                <th>Last Login</th>
                <th>Activity</th>
                <th class="text-end">Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="ad" items="${admins}">
                <tr>
                    <td><strong>${ad.id}</strong></td>
                    <td>${ad.name}</td>
                    <td>${ad.email}</td>
                    <td>
                        <c:choose>
                            <c:when test="${ad.permissions == 'FULL_ACCESS'}">
                                <span class="badge bg-danger">${ad.permissions}</span>
                            </c:when>
                            <c:when test="${ad.permissions == 'READ_ONLY'}">
                                <span class="badge bg-info text-dark">${ad.permissions}</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-secondary">${ad.permissions}</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>${ad.lastLogin}</td>
                    <td>${ad.activityLog}</td>
                    <td class="text-end">
                        <a href="/admins/edit/${ad.id}" class="btn btn-sm btn-warning">Edit</a>
                        <a href="/admins/delete/${ad.id}"
                           class="btn btn-sm btn-danger"
                           onclick="return confirm('Delete this admin?')">Delete</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</c:if>

<%@ include file="footer.jsp" %>