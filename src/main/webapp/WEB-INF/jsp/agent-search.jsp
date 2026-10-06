<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="header.jsp" %>

<div class="container" style="max-width: 700px;">
    <h2 class="page-title">🔍 Search Agent</h2>

    <div class="form-card mb-4">
        <form action="/agents/search/results" method="get">
            <div class="input-group">
                <input type="text" name="id" class="form-control"
                       placeholder="Enter Agent ID (e.g., AG-1001)" required autofocus>
                <button type="submit" class="btn btn-primary">Search</button>
            </div>
        </form>
    </div>

    <c:if test="${not empty searchedId}">
        <c:choose>
            <c:when test="${not empty agent}">
                <div class="card card-modern fade-in">
                    <div class="card-body p-4">
                        <h4 class="card-title mb-3">✅ ${agent.name}</h4>
                        <p class="mb-1"><strong>ID:</strong> ${agent.id}</p>
                        <p class="mb-1"><strong>Email:</strong> ${agent.email}</p>
                        <p class="mb-1"><strong>Specialization:</strong> ${agent.specialization}</p>
                        <p class="mb-1"><strong>Contact:</strong> ${agent.contactNumber}</p>
                        <p class="mb-0"><strong>Rating:</strong>
                            <span class="rating">⭐ ${agent.averageRating}</span>
                            (${agent.totalReviews} reviews)
                        </p>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="alert alert-warning text-center">
                    No agent found with ID: <strong>${searchedId}</strong>
                </div>
            </c:otherwise>
        </c:choose>
    </c:if>

    <a href="/agents/list" class="btn btn-outline-primary mt-3">← Back to List</a>
</div>

<%@ include file="footer.jsp" %>