<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="header.jsp" %>

<div class="container py-4">
    <div class="page-title-bar">
        <h2 class="page-title">🏘️ Property Listings</h2>
        <div class="action-buttons">
            <c:if test="${sessionScope.role == 'ADMIN' || sessionScope.role == 'AGENT'}">
                <a href="/properties/add" class="btn btn-primary">+ Add Property</a>
            </c:if>
            <a href="/properties/search" class="btn btn-outline-primary">🔍 Search</a>
        </div>
    </div>

    <c:if test="${empty properties}"><div class="empty-state"><h3>No Properties Yet</h3></div></c:if>

    <c:if test="${not empty properties}">
        <div class="table-responsive">
            <table class="table table-modern">
                <thead>
                <tr>
                    <th>ID</th><th>Title</th><th>Location</th><th>Price</th><th>Agent</th>
                    <c:if test="${sessionScope.role == 'ADMIN' || sessionScope.role == 'AGENT'}"><th class="text-end">Actions</th></c:if>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="pr" items="${properties}">
                    <tr>
                        <td><strong>${pr.id}</strong></td><td>${pr.title}</td><td>${pr.location}</td><td>${pr.price}</td><td>${agentNames[pr.listingAgentId]}</td>
                        <c:if test="${sessionScope.role == 'ADMIN' || sessionScope.role == 'AGENT'}">
                            <td class="text-end">
                                <a href="/properties/edit/${pr.id}" class="btn btn-sm btn-warning">Edit</a>
                                <a href="/properties/delete/${pr.id}" class="btn btn-sm btn-danger" onclick="return confirm('Delete?')">Delete</a>
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