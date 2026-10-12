<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="header.jsp" %>

<div class="container" style="max-width: 700px;">
    <h2 class="page-title">🔍 Search Admin</h2>

    <div class="form-card mb-4">
        <form action="/admins/search/results" method="get">
            <div class="input-group">
                <input type="text" name="id" class="form-control"
                       placeholder="Enter Admin ID (e.g., ADM-9001)" required autofocus>
                <button type="submit" class="btn btn-primary">Search</button>
            </div>
        </form>
    </div>

    <c:if test="${not empty searchedId}">
        <c:choose>
            <c:when test="${not empty admin}">
                <div class="card card-modern fade-in">
                    <div class="card-body p-4">
                        <h4 class="card-title mb-3">⚙️ ${admin.name}</h4>
                        <p class="mb-1"><strong>ID:</strong> ${admin.id}</p>
                        <p class="mb-1"><strong>Email:</strong> ${admin.email}</p>
                        <p class="mb-1"><strong>Permissions:</strong> ${admin.permissions}</p>
                        <p class="mb-1"><strong>Last Login:</strong> ${admin.lastLogin}</p>
                        <p class="mb-0"><strong>Activity:</strong> ${admin.activityLog}</p>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="alert alert-warning text-center">
                    No admin found with ID: <strong>${searchedId}</strong>
                </div>
            </c:otherwise>
        </c:choose>
    </c:if>

    <a href="/admins/list" class="btn btn-outline-primary mt-3">← Back to List</a>
</div>

<%@ include file="footer.jsp" %>