<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h2 class="page-title mb-0">⭐ Reviews & Ratings</h2>
    <div>
        <a href="/reviews/add" class="btn btn-primary">+ Add Review</a>
        <a href="/reviews/search" class="btn btn-outline-primary">🔍 Search</a>
    </div>
</div>

<p class="text-muted mb-4">Client feedback on agents — automatically updates agent ratings.</p>

<c:if test="${empty reviews}">
    <div class="empty-state">
        <div class="empty-state-icon">📭</div>
        <h3>No Reviews Yet</h3>
        <p class="text-muted">Submit the first review to get started.</p>
        <a href="/reviews/add" class="btn btn-primary">+ Submit First Review</a>
    </div>
</c:if>

<c:if test="${not empty reviews}">
    <div class="table-responsive">
        <table class="table table-modern">
            <thead>
            <tr>
                <th>ID</th>
                <th>Client</th>
                <th>Agent</th>
                <th>Rating</th>
                <th>Comment</th>
                <th>Date</th>
                <th>Status</th>
                <th class="text-end">Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="rv" items="${reviews}">
                <tr>
                    <td><strong>${rv.id}</strong></td>
                    <td>${clientNames[rv.clientId]}</td>
                    <td>${agentNames[rv.agentId]}</td>
                    <td class="rating">
                        <c:forEach begin="1" end="${rv.rating}">⭐</c:forEach>
                        <span class="text-muted ms-1">(${rv.rating}/5)</span>
                    </td>
                    <td>${rv.comment}</td>
                    <td>${rv.reviewDate}</td>
                    <td>
                        <c:choose>
                            <c:when test="${rv.moderationStatus == 'Approved'}">
                                <span class="badge bg-success">${rv.moderationStatus}</span>
                            </c:when>
                            <c:when test="${rv.moderationStatus == 'Pending'}">
                                <span class="badge bg-warning text-dark">${rv.moderationStatus}</span>
                            </c:when>
                            <c:when test="${rv.moderationStatus == 'Rejected'}">
                                <span class="badge bg-danger">${rv.moderationStatus}</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-secondary">${rv.moderationStatus}</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td class="text-end">
                        <a href="/reviews/edit/${rv.id}" class="btn btn-sm btn-warning">Edit</a>
                        <a href="/reviews/delete/${rv.id}"
                           class="btn btn-sm btn-danger"
                           onclick="return confirm('Delete this review?')">Delete</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</c:if>

<%@ include file="footer.jsp" %>