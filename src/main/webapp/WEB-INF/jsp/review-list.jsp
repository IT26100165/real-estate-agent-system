<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="header.jsp" %>

<div class="container py-4">
    <div class="page-title-bar">
        <h2 class="page-title">⭐ Reviews & Ratings</h2>
        <div class="action-buttons">
            <a href="/reviews/add" class="btn btn-primary">+ Add Review</a>
            <a href="/reviews/search" class="btn btn-outline-primary">🔍 Search</a>
        </div>
    </div>

    <c:if test="${empty reviews}"><div class="empty-state"><h3>No Reviews Yet</h3></div></c:if>

    <c:if test="${not empty reviews}">
        <div class="table-responsive">
            <table class="table table-modern">
                <thead>
                <tr>
                    <th>ID</th><th>Client</th><th>Agent</th><th>Rating</th><th>Status</th>
                    <c:if test="${sessionScope.role == 'ADMIN'}"><th class="text-end">Actions</th></c:if>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="rv" items="${reviews}">
                    <tr>
                        <td><strong>${rv.id}</strong></td><td>${clientNames[rv.clientId]}</td><td>${agentNames[rv.agentId]}</td><td>${rv.rating} / 5</td><td>${rv.moderationStatus}</td>
                        <c:if test="${sessionScope.role == 'ADMIN'}">
                            <td class="text-end">
                                <a href="/reviews/edit/${rv.id}" class="btn btn-sm btn-warning">Edit</a>
                                <a href="/reviews/delete/${rv.id}" class="btn btn-sm btn-danger" onclick="return confirm('Delete?')">Delete</a>
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