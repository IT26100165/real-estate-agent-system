<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Agent List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h2>Real Estate Agents (Sorted by Rating)</h2>
    <div class="mb-3">
        <a href="/agents/add" class="btn btn-primary">+ Add New Agent</a>
        <a href="/agents/search" class="btn btn-info">Search Agent</a>
    </div>

    <table class="table table-striped table-bordered">
        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Specialization</th>
            <th>Contact</th>
            <th>Rating</th>
            <th>Reviews</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="a" items="${agents}">
            <tr>
                <td>${a.id}</td>
                <td>${a.name}</td>
                <td>${a.email}</td>
                <td>${a.specialization}</td>
                <td>${a.contactNumber}</td>
                <td>${a.averageRating}</td>
                <td>${a.totalReviews}</td>
                <td>
                    <a href="/agents/delete/${a.id}"
                       class="btn btn-sm btn-danger"
                       onclick="return confirm('Delete this agent?')">Delete</a>
                </td>
            </tr>
        </c:forEach>
        <c:if test="${empty agents}">
            <tr><td colspan="8" class="text-center">No agents found.</td></tr>
        </c:if>
        </tbody>
    </table>
</div>
</body>
</html>