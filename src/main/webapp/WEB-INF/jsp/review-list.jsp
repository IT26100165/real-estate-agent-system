<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="header.jsp" %>

<div class="container py-4">
    <div class="page-title-bar mb-4">
        <h2 class="page-title">
            <i class="bi bi-star text-primary me-2"></i>
            <c:choose>
                <c:when test="${sessionScope.role == 'AGENT'}">My Reviews</c:when>
                <c:otherwise>Reviews & Ratings</c:otherwise>
            </c:choose>
        </h2>
        <div class="action-buttons">
            <c:if test="${sessionScope.role == 'CLIENT'}">
                <a href="/reviews/add" class="btn btn-primary"><i class="bi bi-plus-lg me-1"></i> Add Review</a>
            </c:if>
            <a href="/reviews/search" class="btn btn-outline-primary"><i class="bi bi-search me-1"></i> Search</a>
        </div>
    </div>

    <c:if test="${not empty reviews}">
        <div class="table-responsive">
            <table class="table table-modern align-middle">
                <thead>
                <tr>
                    <th>ID</th><th>Client</th><th>Agent</th><th>Rating</th><th>Moderation</th>
                    <%-- Show Actions column if Admin OR Client --%>
                    <c:if test="${sessionScope.role == 'ADMIN' || sessionScope.role == 'CLIENT'}">
                        <th class="text-end">Actions</th>
                    </c:if>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="rv" items="${reviews}">
                    <tr>
                        <td><span class="text-muted fw-bold">${rv.id}</span></td>
                        <td class="fw-bold text-dark">${clientNames[rv.clientId]}</td>
                        <td class="text-muted">${agentNames[rv.agentId]}</td>
                        <td>
                            <div class="text-warning fw-bold">
                                <c:forEach begin="1" end="${rv.rating}"><i class="bi bi-star-fill"></i></c:forEach>
                                <span class="text-muted ms-1 small">(${rv.rating}/5)</span>
                            </div>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${rv.moderationStatus == 'Approved'}"><span class="status-badge status-approved">Approved</span></c:when>
                                <c:when test="${rv.moderationStatus == 'Pending'}"><span class="status-badge status-pending">Pending</span></c:when>
                                <c:when test="${rv.moderationStatus == 'Rejected'}"><span class="status-badge status-rejected">Rejected</span></c:when>
                            </c:choose>
                        </td>
                        <c:if test="${sessionScope.role == 'ADMIN' || sessionScope.role == 'CLIENT'}">
                            <td class="text-end">
                                <%-- Show buttons if Admin (Full Access) OR if Client owns the review --%>
                                <c:if test="${(sessionScope.role == 'ADMIN' && sessionScope.adminPermissions == 'FULL_ACCESS') || (sessionScope.role == 'CLIENT' && sessionScope.user.id == rv.clientId)}">
                                    <div class="d-flex justify-content-end gap-2">
                                        <a href="/reviews/edit/${rv.id}" class="btn btn-sm btn-outline-primary"><i class="bi bi-pencil"></i></a>
                                        <a href="/reviews/delete/${rv.id}" class="btn btn-sm btn-outline-danger" onclick="return confirm('Delete?')"><i class="bi bi-trash"></i></a>
                                    </div>
                                </c:if>
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