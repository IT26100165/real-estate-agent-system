<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="header.jsp" %>

<div class="container py-4">
    <div class="page-title-bar">
        <h2 class="page-title">📅 Appointments</h2>
        <div class="action-buttons">
            <a href="/appointments/add" class="btn btn-primary">+ Book Appointment</a>
            <a href="/appointments/search" class="btn btn-outline-primary">🔍 Search</a>
        </div>
    </div>

    <c:if test="${empty appointments}"><div class="empty-state"><h3>No Appointments Yet</h3></div></c:if>

    <c:if test="${not empty appointments}">
        <div class="table-responsive">
            <table class="table table-modern">
                <thead>
                <tr>
                    <th>ID</th><th>Client</th><th>Agent</th><th>Date</th><th>Status</th>
                    <c:if test="${sessionScope.role == 'ADMIN' || sessionScope.role == 'AGENT'}"><th class="text-end">Actions</th></c:if>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="ap" items="${appointments}">
                    <tr>
                        <td><strong>${ap.id}</strong></td><td>${clientNames[ap.clientId]}</td><td>${agentNames[ap.agentId]}</td><td>${ap.date} ${ap.timeSlot}</td><td>${ap.status}</td>
                        <c:if test="${sessionScope.role == 'ADMIN' || sessionScope.role == 'AGENT'}">
                            <td class="text-end">
                                <a href="/appointments/edit/${ap.id}" class="btn btn-sm btn-warning">Edit</a>
                                <a href="/appointments/delete/${ap.id}" class="btn btn-sm btn-danger" onclick="return confirm('Delete?')">Delete</a>
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