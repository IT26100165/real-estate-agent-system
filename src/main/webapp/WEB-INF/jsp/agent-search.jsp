<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Search Agent</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4" style="max-width: 700px;">
    <h2>Search Agent by ID</h2>

    <form action="/agents/search/results" method="get" class="mb-4">
        <div class="input-group">
            <input type="text" name="id" class="form-control" placeholder="Enter Agent ID (e.g., AG-1001)" required>
            <button type="submit" class="btn btn-primary">Search</button>
        </div>
    </form>

    <c:if test="${not empty searchedId}">
        <c:choose>
            <c:when test="${not empty agent}">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">${agent.name}</h5>
                        <p class="card-text">
                            <strong>ID:</strong> ${agent.id}<br>
                            <strong>Email:</strong> ${agent.email}<br>
                            <strong>Specialization:</strong> ${agent.specialization}<br>
                            <strong>Contact:</strong> ${agent.contactNumber}<br>
                            <strong>Rating:</strong> ${agent.averageRating} (${agent.totalReviews} reviews)
                        </p>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="alert alert-warning">No agent found with ID: <strong>${searchedId}</strong></div>
            </c:otherwise>
        </c:choose>
    </c:if>

    <a href="/agents/list" class="btn btn-secondary mt-3">Back to List</a>
</div>
</body>
</html>