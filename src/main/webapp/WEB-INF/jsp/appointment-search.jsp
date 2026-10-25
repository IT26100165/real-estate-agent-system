<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="header.jsp" %>

<div class="container py-5" style="max-width: 700px;">
    <h2 class="page-title mb-4">🔍 Search Appointment</h2>

    <div class="form-card mb-4">
        <form action="/appointments/search/results" method="get">
            <div class="input-group">
                <input type="text" name="id" class="form-control" placeholder="Enter Appointment ID" required>
                <button type="submit" class="btn btn-primary">Search</button>
            </div>
        </form>
    </div>

    <c:if test="${not empty searchedId}">
        <c:choose>
            <c:when test="${not empty appointment}">
                <div class="module-card">
                    <h4 class="module-card-title">✅ Appointment ${appointment.id}</h4>
                    <p class="mb-1"><strong>Client:</strong> ${clientName}</p>
                    <p class="mb-1"><strong>Agent:</strong> ${agentName}</p>
                    <p class="mb-1"><strong>Date:</strong> ${appointment.date} @ ${appointment.timeSlot}</p>
                    <p class="mb-0"><strong>Status:</strong> ${appointment.status}</p>
                </div>
            </c:when>
            <c:otherwise><div class="alert alert-warning">No appointment found with ID: ${searchedId}</div></c:otherwise>
        </c:choose>
    </c:if>
    <a href="/appointments/list" class="btn btn-outline-primary mt-3">← Back to List</a>
</div>
<%@ include file="footer.jsp" %>