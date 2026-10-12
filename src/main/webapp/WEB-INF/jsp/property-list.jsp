<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h2 class="page-title mb-0">🏘️ Property Listings</h2>
    <div>
        <a href="/properties/add" class="btn btn-primary">+ Add Property</a>
        <a href="/properties/search" class="btn btn-outline-primary">🔍 Search</a>
    </div>
</div>

<p class="text-muted mb-4">All properties listed by our agents.</p>

<c:if test="${empty properties}">
    <div class="empty-state">
        <div class="empty-state-icon">📭</div>
        <h3>No Properties Yet</h3>
        <p class="text-muted">Add the first property to get started.</p>
        <a href="/properties/add" class="btn btn-primary">+ Add First Property</a>
    </div>
</c:if>

<c:if test="${not empty properties}">
    <div class="table-responsive">
        <table class="table table-modern">
            <thead>
            <tr>
                <th>ID</th>
                <th>Title</th>
                <th>Location</th>
                <th>Price (LKR)</th>
                <th>Type</th>
                <th>Beds</th>
                <th>Baths</th>
                <th>Agent</th>
                <th>Status</th>
                <th class="text-end">Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="pr" items="${properties}">
                <tr>
                    <td><strong>${pr.id}</strong></td>
                    <td>${pr.title}</td>
                    <td>${pr.location}</td>
                    <td>${pr.price}</td>
                    <td><span class="badge bg-light text-dark">${pr.propertyType}</span></td>
                    <td>${pr.bedrooms}</td>
                    <td>${pr.bathrooms}</td>
                    <td>${agentNames[pr.listingAgentId]}</td>
                    <td>
                        <c:choose>
                            <c:when test="${pr.availabilityStatus == 'Available'}">
                                <span class="badge bg-success">${pr.availabilityStatus}</span>
                            </c:when>
                            <c:when test="${pr.availabilityStatus == 'Sold'}">
                                <span class="badge bg-danger">${pr.availabilityStatus}</span>
                            </c:when>
                            <c:when test="${pr.availabilityStatus == 'Rented'}">
                                <span class="badge bg-warning text-dark">${pr.availabilityStatus}</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-secondary">${pr.availabilityStatus}</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td class="text-end">
                        <a href="/properties/edit/${pr.id}" class="btn btn-sm btn-warning">Edit</a>
                        <a href="/properties/delete/${pr.id}"
                           class="btn btn-sm btn-danger"
                           onclick="return confirm('Delete this property?')">Delete</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</c:if>

<%@ include file="footer.jsp" %>