<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="header.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h2 class="page-title mb-0">📅 Appointments</h2>
    <div>
        <a href="/appointments/add" class="btn btn-primary">+ Book Appointment</a>
        <a href="/appointments/search" class="btn btn-outline-primary">🔍 Search</a>
    </div>
</div>

<p class="text-muted mb-4">All scheduled appointments between clients and agents.</p>

<c:if test="${empty appointments}">
    <div class="empty-state">
        <div class="empty-state-icon">📭</div>
        <h3>No Appointments Yet</h3>
        <p class="text-muted">Book the first appointment to get started.</p>
        <a href="/appointments/add" class="btn btn-primary">+ Book First Appointment</a>
    </div>
</c:if>

<c:if test="${not empty appointments}">
    <div class="table-responsive">
        <table class="table table-modern">
            <thead>
            <tr>
                <th>ID</th>
                <th>Client</th>
                <th>Agent</th>
                <th>Date</th>
                <th>Time</th>
                <th>Status</th>
                <th>Property</th>
                <th class="text-end">Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="ap" items="${appointments}">
                <tr>
                    <td><strong>${ap.id}</strong></td>
                    <td>${clientNames[ap.clientId]}</td>
                    <td>${agentNames[ap.agentId]}</td>
                    <td>${ap.date}</td>
                    <td>${ap.timeSlot}</td>
                    <td>
                        <c:choose>
                            <c:when test="${ap.status == 'Confirmed'}">
                                <span class="badge bg-success">${ap.status}</span>
                            </c:when>
                            <c:when test="${ap.status == 'Pending'}">
                                <span class="badge bg-warning text-dark">${ap.status}</span>
                            </c:when>
                            <c:when test="${ap.status == 'Completed'}">
                                <span class="badge bg-primary">${ap.status}</span>
                            </c:when>
                            <c:when test="${ap.status == 'Cancelled'}">
                                <span class="badge bg-danger">${ap.status}</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-secondary">${ap.status}</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>${ap.propertyDescription}</td>
                    <td class="text-end">
                        <a href="/appointments/edit/${ap.id}" class="btn btn-sm btn-warning">Edit</a>
                        <a href="/appointments/delete/${ap.id}"
                           class="btn btn-sm btn-danger"
                           onclick="return confirm('Delete this appointment?')">Delete</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</c:if>

<%@ include file="footer.jsp" %>