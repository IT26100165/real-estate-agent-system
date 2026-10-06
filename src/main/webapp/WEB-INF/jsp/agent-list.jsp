<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h2 class="page-title mb-0">🤝 Real Estate Agents</h2>
    <div>
        <a href="/agents/add" class="btn btn-primary">+ Add Agent</a>
        <a href="/agents/search" class="btn btn-outline-primary">🔍 Search</a>
    </div>
</div>

<p class="text-muted mb-4">Sorted by average rating — highest performers first.</p>

<c:if test="${empty agents}">
    <div class="empty-state">
        <div class="empty-state-icon">📭</div>
        <h3>No Agents Yet</h3>
        <p class="text-muted">Get started by adding your first agent.</p>
        <a href="/agents/add" class="btn btn-primary">+ Add First Agent</a>
    </div>
</c:if>

<c:if test="${not empty agents}">
    <div class="table-responsive">
        <table class="table table-modern">
            <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Specialization</th>
                <th>Contact</th>
                <th>Rating</th>
                <th>Reviews</th>
                <th class="text-end">Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="a" items="${agents}">
                <tr>
                    <td><strong>${a.id}</strong></td>
                    <td>${a.name}</td>
                    <td>${a.email}</td>
                    <td><span class="badge bg-light text-dark">${a.specialization}</span></td>
                    <td>${a.contactNumber}</td>
                    <td class="rating">⭐ ${a.averageRating}</td>
                    <td>${a.totalReviews}</td>
                    <td class="text-end">
                        <a href="/agents/edit/${a.id}" class="btn btn-sm btn-warning">Edit</a>
                        <a href="/agents/delete/${a.id}"
                           class="btn btn-sm btn-danger"
                           onclick="return confirm('Delete this agent?')">Delete</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</c:if>

<%@ include file="footer.jsp" %>