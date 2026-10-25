<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="header.jsp" %>

<div class="container py-4">
    <div class="page-title-bar">
        <h2 class="page-title">👤 Client Directory</h2>
        <div class="action-buttons">
            <c:if test="${sessionScope.role == 'ADMIN'}">
                <a href="/clients/add" class="btn btn-primary">+ Add Client</a>
            </c:if>
            <a href="/clients/search" class="btn btn-outline-primary">🔍 Search</a>
        </div>
    </div>

    <c:if test="${empty clients}"><div class="empty-state"><h3>No Clients Yet</h3></div></c:if>

    <c:if test="${not empty clients}">
        <div class="table-responsive">
            <table class="table table-modern">
                <thead>
                <tr>
                    <th>ID</th><th>Name</th><th>Email</th><th>Phone</th><th>Preference</th>
                    <c:if test="${sessionScope.role == 'ADMIN'}"><th class="text-end">Actions</th></c:if>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="cl" items="${clients}">
                    <tr>
                        <td><strong>${cl.id}</strong></td><td>${cl.name}</td><td>${cl.email}</td><td>${cl.phoneNumber}</td><td>${cl.propertyPreference}</td>
                        <c:if test="${sessionScope.role == 'ADMIN'}">
                            <td class="text-end">
                                <a href="/clients/edit/${cl.id}" class="btn btn-sm btn-warning">Edit</a>
                                <a href="/clients/delete/${cl.id}" class="btn btn-sm btn-danger" onclick="return confirm('Delete?')">Delete</a>
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