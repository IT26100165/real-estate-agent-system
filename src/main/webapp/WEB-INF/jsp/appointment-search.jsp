<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="header.jsp" %>

<div class="container" style="max-width: 700px;">
    <h2 class="page-title">🔍 Search Appointment</h2>

    <div class="form-card mb-4">
        <form action="/appointments/search/results" method="get">
            <div class="input-group">
                <input type="text" name="id" class="form-control"
                       placeholder="Enter Appointment ID (e.g., APP-3001)" required autofocus>
                <button type="submit" class="btn btn-primary">Search</button>
            </div>
        </form>
    </div>

    <c:if test="${not empty searchedId}">
        <c:choose>
            <c:when test="${not empty appointment}">
                <div class="card card-modern fade-in">
                    <div class="card-body p-4">
                        <h4 class="card-title mb-3">✅ Appointment ${appointment.id}</h4>
                        <p class="mb-1"><strong>Client:</strong> ${clientName} (${appointment.clientId})</p>
                        <p class="mb-1"><strong>Agent:</strong> ${agentName} (${appointment.agentId})</p>
                        <p class="mb-1"><strong>Date:</strong> ${appointment.date}</p>
                        <p class="mb-1"><strong>Time:</strong> ${appointment.timeSlot}</p>
                        <p class="mb-1"><strong>Status:</strong> ${appointment.status}</p>
                        <p class="mb-1"><strong>Property:</strong> ${appointment.propertyDescription}</p>
                        <p class="mb-0"><strong>Notes:</strong> ${appointment.notes}</p>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="alert alert-warning text-center">
                    No appointment found with ID: <strong>${searchedId}</strong>
                </div>
            </c:otherwise>
        </c:choose>
    </c:if>

    <a href="/appointments/list" class="btn btn-outline-primary mt-3">← Back to List</a>
</div>

<%@ include file="footer.jsp" %>