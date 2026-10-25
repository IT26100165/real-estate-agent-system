<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="header.jsp" %>

<div class="container py-4">
    <div class="page-title-bar">
        <h2 class="page-title">🤝 Real Estate Agents</h2>
        <div class="action-buttons">
            <c:if test="${sessionScope.role == 'ADMIN'}">
                <a href="/agents/add" class="btn btn-primary">+ Add Agent</a>
            </c:if>
            <a href="/agents/search" class="btn btn-outline-primary">🔍 Search</a>
        </div>
    </div>

    <p class="text-muted mb-4">Sorted by average rating — highest performers first.</p>

    <c:if test="${not empty agents}">
        <div class="table-responsive">
            <table class="table table-modern">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Specialization</th>
                    <th>Contact</th>
                    <th>Rating</th>
                    <th>Reviews</th>
                    <c:if test="${sessionScope.role == 'ADMIN'}">
                        <th class="text-end">Actions</th>
                    </c:if>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="a" items="${agents}">
                    <tr>
                        <td><strong>${a.id}</strong></td>
                        <td>${a.name}</td>
                        <td>${a.email}</td>
                        <td><span class="badge bg-light text-dark">${a.specialization}</span></td>
                        <td>${a.contactNumber}</td>
                        <td class="rating">⭐ ${a.averageRating}</td>
                        <td>${a.totalReviews}</td>
                        <c:if test="${sessionScope.role == 'ADMIN'}">
                            <td class="text-end">
                                <div class="d-flex justify-content-end gap-2">
                                    <a href="/agents/edit/${a.id}" class="btn btn-sm btn-warning">Edit</a>
                                    <a href="/agents/delete/${a.id}" class="btn btn-sm btn-danger" onclick="return confirm('Delete?')">Delete</a>
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