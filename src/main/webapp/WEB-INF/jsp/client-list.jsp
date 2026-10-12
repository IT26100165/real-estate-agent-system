<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h2 class="page-title mb-0">👤 Registered Clients</h2>
    <div>
        <a href="/clients/add" class="btn btn-primary">+ Add Client</a>
        <a href="/clients/search" class="btn btn-outline-primary">🔍 Search</a>
    </div>
</div>

<p class="text-muted mb-4">All clients registered in the system.</p>

<c:if test="${empty clients}">
    <div class="empty-state">
        <div class="empty-state-icon">📭</div>
        <h3>No Clients Yet</h3>
        <p class="text-muted">Get started by adding your first client.</p>
        <a href="/clients/add" class="btn btn-primary">+ Add First Client</a>
    </div>
</c:if>

<c:if test="${not empty clients}">
    <div class="table-responsive">
        <table class="table table-modern">
            <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Address</th>
                <th>Preference</th>
                <th>Registered</th>
                <th class="text-end">Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="cl" items="${clients}">
                <tr>
                    <td><strong>${cl.id}</strong></td>
                    <td>${cl.name}</td>
                    <td>${cl.email}</td>
                    <td>${cl.phoneNumber}</td>
                    <td>${cl.address}</td>
                    <td><span class="badge bg-light text-dark">${cl.propertyPreference}</span></td>
                    <td>${cl.registrationDate}</td>
                    <td class="text-end">
                        <a href="/clients/edit/${cl.id}" class="btn btn-sm btn-warning">Edit</a>
                        <a href="/clients/delete/${cl.id}"
                           class="btn btn-sm btn-danger"
                           onclick="return confirm('Delete this client?')">Delete</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</c:if>

<%@ include file="footer.jsp" %>