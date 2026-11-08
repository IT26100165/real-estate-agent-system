<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ include file="header.jsp" %>

<div class="container py-4">
    <div class="page-title-bar mb-4">
        <h2 class="page-title"><i class="bi bi-person-badge text-primary me-2"></i>Client Directory</h2>
        <div class="action-buttons">
            <c:if test="${sessionScope.role == 'ADMIN' && sessionScope.adminPermissions == 'FULL_ACCESS'}">
                <a href="/clients/add" class="btn btn-primary"><i class="bi bi-plus-lg me-1"></i> Add Client</a>
            </c:if>
            <a href="/clients/search" class="btn btn-outline-primary"><i class="bi bi-search me-1"></i> Search</a>
        </div>
    </div>

    <c:if test="${not empty clients}">
        <div class="table-responsive">
            <table class="table table-modern align-middle">
                <thead>
                <tr>
                    <th>ID</th><th>Client Name</th><th>Email</th><th>Preference</th><th>Registered</th>
                    <c:if test="${sessionScope.role == 'ADMIN' && sessionScope.adminPermissions == 'FULL_ACCESS'}">
                        <th class="text-end">Actions</th>
                    </c:if>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="cl" items="${clients}">
                    <tr>
                        <td><span class="text-muted fw-bold">${cl.id}</span></td>
                        <td>
                            <div class="d-flex align-items-center">
                                <div class="avatar-circle" style="background: #d1fae5; color: #065f46;">${fn:substring(cl.name, 0, 1)}</div>
                                <div>
                                    <div class="fw-bold text-dark">${cl.name}</div>
                                    <div class="small text-muted"><i class="bi bi-telephone me-1"></i>${cl.phoneNumber}</div>
                                </div>
                            </div>
                        </td>
                        <td class="text-muted">${cl.email}</td>
                        <td><span class="badge bg-light text-dark border">${cl.propertyPreference}</span></td>
                        <td class="small text-muted">${cl.registrationDate}</td>
                        <c:if test="${sessionScope.role == 'ADMIN' && sessionScope.adminPermissions == 'FULL_ACCESS'}">
                            <td class="text-end">
                                <div class="d-flex justify-content-end gap-2">
                                    <a href="/clients/edit/${cl.id}" class="btn btn-sm btn-outline-primary"><i class="bi bi-pencil"></i></a>
                                    <a href="/clients/delete/${cl.id}" class="btn btn-sm btn-outline-danger" onclick="return confirm('Delete?')"><i class="bi bi-trash"></i></a>
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