<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="header.jsp" %>

<div class="container py-5" style="max-width: 700px;">
    <h2 class="page-title mb-4">🔍 Search Agent</h2>

    <div class="form-card mb-4">
        <form action="/agents/search/results" method="get">
            <div class="input-group">
                <input type="text" name="id" class="form-control" placeholder="Enter Agent ID (e.g., AG-1001)" required>
                <button type="submit" class="btn btn-primary">Search</button>
            </div>
        </form>
    </div>

    <c:if test="${not empty searchedId}">
        <c:choose>
            <c:when test="${not empty agent}">
                <div class="module-card">
                    <h4 class="module-card-title">✅ ${agent.name}</h4>
                    <p class="mb-1"><strong>ID:</strong> ${agent.id}</p>
                    <p class="mb-1"><strong>Email:</strong> ${agent.email}</p>
                    <p class="mb-1"><strong>Specialization:</strong> ${agent.specialization}</p>
                    <p class="mb-1"><strong>Contact:</strong> ${agent.contactNumber}</p>
                    <p class="mb-0"><strong>Rating:</strong> ⭐ ${agent.averageRating}</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="alert alert-warning">No agent found with ID: ${searchedId}</div>
            </c:otherwise>
        </c:choose>
    </c:if>
    <a href="/agents/list" class="btn btn-outline-primary mt-3">← Back to List</a>
</div>
<%@ include file="footer.jsp" %>