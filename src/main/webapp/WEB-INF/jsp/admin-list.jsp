<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ include file="header.jsp" %>

<div class="container py-4">
    <div class="page-title-bar mb-4">
        <h2 class="page-title"><i class="bi bi-shield-lock text-primary me-2"></i>System Administrators</h2>
        <div class="action-buttons">
            <%-- ONLY SHOW ADD BUTTON IF FULL_ACCESS --%>
            <c:if test="${sessionScope.adminPermissions == 'FULL_ACCESS'}">
                <a href="/admins/add" class="btn btn-primary"><i class="bi bi-plus-lg me-1"></i> Add Admin</a>
            </c:if>
            <a href="/admins/search" class="btn btn-outline-primary"><i class="bi bi-search me-1"></i> Search</a>
        </div>
    </div>

    <c:if test="${not empty admins}">
        <div class="table-responsive">
            <table class="table table-modern align-middle">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Administrator</th>
                    <th>Email</th>
                    <th>Permissions</th>
                    <th>Last Login</th>
                    <%-- ONLY SHOW ACTIONS COLUMN IF FULL_ACCESS --%>
                    <c:if test="${sessionScope.adminPermissions == 'FULL_ACCESS'}">
                        <th class="text-end">Actions</th>
                    </c:if>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="ad" items="${admins}">
                    <tr>
                        <td><span class="text-muted fw-bold">${ad.id}</span></td>
                        <td>
                            <div class="d-flex align-items-center">
                                <div class="avatar-circle" style="background: #fef3c7; color: #92400e;"><i class="bi bi-shield-fill"></i></div>
                                <div class="fw-bold text-dark">${ad.name}</div>
                            </div>
                        </td>
                        <td class="text-muted">${ad.email}</td>
                        <td>
                            <c:choose>
                                <c:when test="${ad.permissions == 'FULL_ACCESS'}">
                                    <span class="badge bg-danger-subtle text-danger border border-danger-subtle rounded-pill px-2">FULL_ACCESS</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-info-subtle text-info border border-info-subtle rounded-pill px-2">READ_ONLY</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td class="small text-muted">${ad.lastLogin}</td>

                        <%-- ONLY SHOW EDIT/DELETE BUTTONS IF FULL_ACCESS --%>
                        <c:if test="${sessionScope.adminPermissions == 'FULL_ACCESS'}">
                            <td class="text-end">
                                <div class="d-flex justify-content-end gap-2">
                                    <a href="/admins/edit/${ad.id}" class="btn btn-sm btn-outline-primary"><i class="bi bi-pencil"></i></a>
                                    <a href="/admins/delete/${ad.id}" class="btn btn-sm btn-outline-danger" onclick="return confirm('Delete?')"><i class="bi bi-trash"></i></a>
                                </div>
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