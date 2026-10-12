<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="header.jsp" %>

<div class="container" style="max-width: 700px;">
    <h2 class="page-title">🔍 Search Review</h2>

    <div class="form-card mb-4">
        <form action="/reviews/search/results" method="get">
            <div class="input-group">
                <input type="text" name="id" class="form-control"
                       placeholder="Enter Review ID (e.g., REV-5001)" required autofocus>
                <button type="submit" class="btn btn-primary">Search</button>
            </div>
        </form>
    </div>

    <c:if test="${not empty searchedId}">
        <c:choose>
            <c:when test="${not empty review}">
                <div class="card card-modern fade-in">
                    <div class="card-body p-4">
                        <h4 class="card-title mb-3">⭐ Review ${review.id}</h4>
                        <p class="mb-1"><strong>Client:</strong> ${clientName} (${review.clientId})</p>
                        <p class="mb-1"><strong>Agent:</strong> ${agentName} (${review.agentId})</p>
                        <p class="mb-1"><strong>Rating:</strong>
                            <span class="rating">
                                <c:forEach begin="1" end="${review.rating}">⭐</c:forEach>
                            </span>
                            (${review.rating}/5)
                        </p>
                        <p class="mb-1"><strong>Comment:</strong> ${review.comment}</p>
                        <p class="mb-1"><strong>Date:</strong> ${review.reviewDate}</p>
                        <p class="mb-0"><strong>Status:</strong> ${review.moderationStatus}</p>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="alert alert-warning text-center">
                    No review found with ID: <strong>${searchedId}</strong>
                </div>
            </c:otherwise>
        </c:choose>
    </c:if>

    <a href="/reviews/list" class="btn btn-outline-primary mt-3">← Back to List</a>
</div>

<%@ include file="footer.jsp" %>