<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="header.jsp" %>

<div class="container py-4">
    <div class="page-title-bar">
        <h2 class="page-title">⚙️ System Administrators</h2>
        <div class="action-buttons">
            <c:if test="${sessionScope.role == 'ADMIN'}">
                <a href="/admins/add" class="btn btn-primary">+ Add Admin</a>
            </c:if>
            <a href="/admins/search" class="btn btn-outline-primary">🔍 Search</a>
        </div>
    </div>

    <c:if test="${empty admins}"><div class="empty-state"><h3>No Admins Yet</h3></div></c:if>

    <c:if test="${not empty admins}">
        <div class="table-responsive">
            <table class="table table-modern">
                <thead>
                <tr>
                    <th>ID</th><th>Name</th><th>Email</th><th>Permissions</th>
                    <c:if test="${sessionScope.role == 'ADMIN'}"><th class="text-end">Actions</th></c:if>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="ad" items="${admins}">
                    <tr>
                        <td><strong>${ad.id}</strong></td><td>${ad.name}</td><td>${ad.email}</td><td>${ad.permissions}</td>
                        <c:if test="${sessionScope.role == 'ADMIN'}">
                            <td class="text-end">
                                <a href="/admins/edit/${ad.id}" class="btn btn-sm btn-warning">Edit</a>
                                <a href="/admins/delete/${ad.id}" class="btn btn-sm btn-danger" onclick="return confirm('Delete?')">Delete</a>
                            </td>
                        </c:if>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </c:if>
</div>

<%@ include file="footer.jsp" %>