<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="header.jsp" %>

<div class="container" style="max-width: 700px;">
    <h2 class="page-title">🔍 Search Property</h2>

    <div class="form-card mb-4">
        <form action="/properties/search/results" method="get">
            <div class="input-group">
                <input type="text" name="id" class="form-control"
                       placeholder="Enter Property ID (e.g., PROP-4001)" required autofocus>
                <button type="submit" class="btn btn-primary">Search</button>
            </div>
        </form>
    </div>

    <c:if test="${not empty searchedId}">
        <c:choose>
            <c:when test="${not empty property}">
                <div class="card card-modern fade-in">
                    <div class="card-body p-4">
                        <h4 class="card-title mb-3">🏘️ ${property.title}</h4>
                        <p class="mb-1"><strong>ID:</strong> ${property.id}</p>
                        <p class="mb-1"><strong>Location:</strong> ${property.location}</p>
                        <p class="mb-1"><strong>Price:</strong> LKR ${property.price}</p>
                        <p class="mb-1"><strong>Type:</strong> ${property.propertyType}</p>
                        <p class="mb-1"><strong>Bedrooms:</strong> ${property.bedrooms}</p>
                        <p class="mb-1"><strong>Bathrooms:</strong> ${property.bathrooms}</p>
                        <p class="mb-1"><strong>Agent:</strong> ${agentName} (${property.listingAgentId})</p>
                        <p class="mb-1"><strong>Listed:</strong> ${property.listedDate}</p>
                        <p class="mb-1"><strong>Status:</strong> ${property.availabilityStatus}</p>
                        <p class="mb-0"><strong>Description:</strong> ${property.description}</p>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="alert alert-warning text-center">
                    No property found with ID: <strong>${searchedId}</strong>
                </div>
            </c:otherwise>
        </c:choose>
    </c:if>

    <a href="/properties/list" class="btn btn-outline-primary mt-3">← Back to List</a>
</div>

<%@ include file="footer.jsp" %>