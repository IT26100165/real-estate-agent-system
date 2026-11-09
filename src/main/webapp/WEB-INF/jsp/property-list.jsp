<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ include file="header.jsp" %>

<div class="container py-4">
    <div class="page-title-bar mb-4">
        <h2 class="page-title">
            <i class="bi bi-house-door text-primary me-2"></i>
            <c:choose>
                <c:when test="${sessionScope.role == 'AGENT'}">My Property Listings</c:when>
                <c:otherwise>All Property Listings</c:otherwise>
            </c:choose>
        </h2>
        <div class="action-buttons">
            <c:if test="${(sessionScope.role == 'ADMIN' && sessionScope.adminPermissions == 'FULL_ACCESS') || sessionScope.role == 'AGENT'}">
                <a href="/properties/add" class="btn btn-primary"><i class="bi bi-plus-lg me-1"></i> Add Property</a>
            </c:if>
            <a href="/properties/search" class="btn btn-outline-primary"><i class="bi bi-search me-1"></i> Search</a>
        </div>
    </div>

    <c:if test="${not empty properties}">
        <div class="table-responsive">
            <table class="table table-modern align-middle">
                <thead>
                <tr>
                    <th>Property Details</th>
                    <th>Location</th>
                    <th>Price</th>
                    <th>Agent</th>
                    <th>Status</th>
                    <c:if test="${(sessionScope.role == 'ADMIN' && sessionScope.adminPermissions == 'FULL_ACCESS') || sessionScope.role == 'AGENT'}">
                        <th class="text-end">Actions</th>
                    </c:if>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="pr" items="${properties}">
                    <tr>
                        <td>
                            <div class="fw-bold text-dark">${pr.title}</div>
                            <div class="small text-muted">${pr.id} • ${pr.bedrooms} Beds • ${pr.bathrooms} Baths</div>
                        </td>
                        <td class="text-muted"><i class="bi bi-geo-alt me-1"></i>${pr.location}</td>
                        <td class="fw-bold">LKR ${pr.price}</td>
                        <td class="text-muted">${agentNames[pr.listingAgentId]}</td>
                        <td>
                            <c:choose>
                                <c:when test="${pr.availabilityStatus == 'Available'}"><span class="status-badge status-available">Available</span></c:when>
                                <c:when test="${pr.availabilityStatus == 'Sold'}"><span class="status-badge status-sold">Sold</span></c:when>
                                <c:when test="${pr.availabilityStatus == 'Rented'}"><span class="status-badge status-rented">Rented</span></c:when>
                            </c:choose>
                        </td>
                        <c:if test="${(sessionScope.role == 'ADMIN' && sessionScope.adminPermissions == 'FULL_ACCESS') || sessionScope.role == 'AGENT'}">
                            <td class="text-end">
                                <%-- ONLY SHOW BUTTONS IF ADMIN OR IF AGENT OWNS THE PROPERTY --%>
                                <c:if test="${sessionScope.role == 'ADMIN' || (sessionScope.role == 'AGENT' && sessionScope.user.id == pr.listingAgentId)}">
                                    <div class="d-flex justify-content-end gap-2">
                                        <a href="/properties/edit/${pr.id}" class="btn btn-sm btn-outline-primary"><i class="bi bi-pencil"></i></a>
                                        <a href="/properties/delete/${pr.id}" class="btn btn-sm btn-outline-danger" onclick="return confirm('Delete?')"><i class="bi bi-trash"></i></a>
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