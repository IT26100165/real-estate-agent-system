<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ include file="header.jsp" %>

<div class="container py-4">
    <div class="page-title-bar mb-4">
        <h2 class="page-title"><i class="bi bi-people text-primary me-2"></i>Real Estate Agents</h2>
        <div class="action-buttons">
            <c:if test="${sessionScope.role == 'ADMIN'}">
                <a href="/agents/add" class="btn btn-primary"><i class="bi bi-plus-lg me-1"></i> Add Agent</a>
            </c:if>
            <a href="/agents/search" class="btn btn-outline-primary"><i class="bi bi-search me-1"></i> Search</a>
        </div>
    </div>

    <c:if test="${not empty agents}">
        <div class="table-responsive">
            <table class="table table-modern align-middle">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Agent Name</th>
                    <th>Email</th>
                    <th>Specialization</th>
                    <th>Rating</th>
                    <c:if test="${sessionScope.role == 'ADMIN'}">
                        <th class="text-end">Actions</th>
                    </c:if>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="a" items="${agents}">
                    <tr>
                        <td><span class="text-muted fw-bold">${a.id}</span></td>
                        <td>
                            <!-- AVATAR INITIALS -->
                            <div class="d-flex align-items-center">
                                <div class="avatar-circle">${fn:substring(a.name, 0, 1)}</div>
                                <div>
                                    <div class="fw-bold text-dark">${a.name}</div>
                                    <div class="small text-muted">${a.contactNumber}</div>
                                </div>
                            </div>
                        </td>
                        <td class="text-muted">${a.email}</td>
                        <td><span class="badge bg-light text-dark border">${a.specialization}</span></td>
                        <td>
                            <!-- BEAUTIFUL RATING -->
                            <div class="d-flex align-items-center gap-1">
                                <span class="text-warning fw-bold"><i class="bi bi-star-fill"></i> ${a.averageRating}</span>
                                <span class="small text-muted">(${a.totalReviews})</span>
                            </div>
                        </td>
                        <c:if test="${sessionScope.role == 'ADMIN'}">
                            <td class="text-end">
                                <div class="d-flex justify-content-end gap-2">
                                    <a href="/agents/edit/${a.id}" class="btn btn-sm btn-outline-primary"><i class="bi bi-pencil"></i></a>
                                    <a href="/agents/delete/${a.id}" class="btn btn-sm btn-outline-danger" onclick="return confirm('Delete?')"><i class="bi bi-trash"></i></a>
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