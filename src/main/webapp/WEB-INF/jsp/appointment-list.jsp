<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="header.jsp" %>

<div class="container py-4">
    <div class="page-title-bar mb-4">
        <h2 class="page-title">
            <i class="bi bi-calendar-event text-primary me-2"></i>
            <c:choose>
                <c:when test="${sessionScope.role == 'AGENT'}">My Schedule</c:when>
                <c:when test="${sessionScope.role == 'CLIENT'}">My Appointments</c:when>
                <c:otherwise>All Appointments</c:otherwise>
            </c:choose>
        </h2>
        <div class="action-buttons">
            <%-- ONLY CLIENTS AND FULL-ACCESS ADMINS CAN BOOK --%>
            <c:if test="${sessionScope.role == 'CLIENT' || (sessionScope.role == 'ADMIN' && sessionScope.adminPermissions == 'FULL_ACCESS')}">
                <a href="/appointments/add" class="btn btn-primary"><i class="bi bi-plus-lg me-1"></i> Book Appointment</a>
            </c:if>
            <a href="/appointments/search" class="btn btn-outline-primary"><i class="bi bi-search me-1"></i> Search</a>
        </div>
    </div>

    <c:if test="${not empty appointments}">
        <div class="table-responsive">
            <table class="table table-modern align-middle">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Client</th>
                    <th>Agent</th>
                    <th>Schedule</th>
                    <th>Status</th>
                    <c:if test="${(sessionScope.role == 'ADMIN' && sessionScope.adminPermissions == 'FULL_ACCESS') || sessionScope.role == 'AGENT'}">
                        <th class="text-end">Actions</th>
                    </c:if>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="ap" items="${appointments}">
                    <tr>
                        <td><span class="text-muted fw-bold">${ap.id}</span></td>
                        <td class="fw-bold text-dark">${clientNames[ap.clientId]}</td>
                        <td class="text-muted">${agentNames[ap.agentId]}</td>
                        <td>
                            <div class="fw-bold text-dark">${ap.date}</div>
                            <div class="small text-muted"><i class="bi bi-clock me-1"></i>${ap.timeSlot}</div>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${ap.status == 'Confirmed'}"><span class="status-badge status-confirmed">Confirmed</span></c:when>
                                <c:when test="${ap.status == 'Pending'}"><span class="status-badge status-pending">Pending</span></c:when>
                                <c:when test="${ap.status == 'Completed'}"><span class="status-badge status-available">Completed</span></c:when>
                                <c:when test="${ap.status == 'Cancelled'}"><span class="status-badge status-sold">Cancelled</span></c:when>
                            </c:choose>
                        </td>
                        <c:if test="${(sessionScope.role == 'ADMIN' && sessionScope.adminPermissions == 'FULL_ACCESS') || sessionScope.role == 'AGENT'}">
                            <td class="text-end">
                                <c:if test="${sessionScope.role == 'ADMIN' || (sessionScope.role == 'AGENT' && sessionScope.user.id == ap.agentId)}">
                                    <div class="d-flex justify-content-end gap-2">
                                        <a href="/appointments/edit/${ap.id}" class="btn btn-sm btn-outline-primary"><i class="bi bi-pencil"></i></a>
                                        <a href="/appointments/delete/${ap.id}" class="btn btn-sm btn-outline-danger" onclick="return confirm('Delete?')"><i class="bi bi-trash"></i></a>
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