<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="header.jsp" %>

<div class="container" style="max-width: 700px;">
    <h2 class="page-title">🔍 Search Client</h2>

    <div class="form-card mb-4">
        <form action="/clients/search/results" method="get">
            <div class="input-group">
                <input type="text" name="id" class="form-control"
                       placeholder="Enter Client ID (e.g., CL-2001)" required autofocus>
                <button type="submit" class="btn btn-primary">Search</button>
            </div>
        </form>
    </div>

    <c:if test="${not empty searchedId}">
        <c:choose>
            <c:when test="${not empty client}">
                <div class="card card-modern fade-in">
                    <div class="card-body p-4">
                        <h4 class="card-title mb-3">✅ ${client.name}</h4>
                        <p class="mb-1"><strong>ID:</strong> ${client.id}</p>
                        <p class="mb-1"><strong>Email:</strong> ${client.email}</p>
                        <p class="mb-1"><strong>Phone:</strong> ${client.phoneNumber}</p>
                        <p class="mb-1"><strong>Address:</strong> ${client.address}</p>
                        <p class="mb-1"><strong>Preference:</strong> ${client.propertyPreference}</p>
                        <p class="mb-0"><strong>Registered:</strong> ${client.registrationDate}</p>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="alert alert-warning text-center">
                    No client found with ID: <strong>${searchedId}</strong>
                </div>
            </c:otherwise>
        </c:choose>
    </c:if>

    <a href="/clients/list" class="btn btn-outline-primary mt-3">← Back to List</a>
</div>

<%@ include file="footer.jsp" %>