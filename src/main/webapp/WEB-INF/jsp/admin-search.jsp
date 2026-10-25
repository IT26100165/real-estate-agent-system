<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="header.jsp" %>

<div class="container py-5" style="max-width: 650px;">
    <h2 class="page-title mb-4">🔍 Search Admin</h2>

    <div class="form-card mb-4">
        <form action="/admins/search/results" method="get">
            <div class="input-group">
                <input type="text" name="id" class="form-control" placeholder="Enter Admin ID" required>
                <button type="submit" class="btn btn-primary">Search</button>
            </div>
        </form>
    </div>

    <c:if test="${not empty searchedId}">
        <c:choose>
            <c:when test="${not empty admin}">
                <div class="module-card">
                    <h4 class="module-card-title">⚙️ ${admin.name}</h4>
                    <p class="mb-1"><strong>ID:</strong> ${admin.id}</p>
                    <p class="mb-1"><strong>Email:</strong> ${admin.email}</p>
                    <p class="mb-0"><strong>Permissions:</strong> ${admin.permissions}</p>
                </div>
            </c:when>
            <c:otherwise><div class="alert alert-warning">No admin found with ID: ${searchedId}</div></c:otherwise>
        </c:choose>
    </c:if>
    <a href="/admins/list" class="btn btn-outline-primary mt-3">← Back to List</a>
</div>
<%@ include file="footer.jsp" %>