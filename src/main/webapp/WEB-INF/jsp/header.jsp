<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EstateHub — Real Estate Agent Finder</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link href="/css/style.css" rel="stylesheet">
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-custom">
    <div class="container">
        <a class="navbar-brand" href="/">🏠 EstateHub</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navMenu">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navMenu">
            <ul class="navbar-nav ms-auto align-items-center">
                <li class="nav-item"><a class="nav-link" href="/">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="/agents/list">Agents</a></li>
                <li class="nav-item"><a class="nav-link" href="/clients/list">Clients</a></li>
                <li class="nav-item"><a class="nav-link" href="/appointments/list">Appointments</a></li>
                <li class="nav-item"><a class="nav-link" href="/properties/list">Properties</a></li>
                <li class="nav-item"><a class="nav-link" href="/reviews/list">Reviews</a></li>
                <li class="nav-item"><a class="nav-link" href="/admins/list">Admin</a></li>

                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <li class="nav-item ms-3">
                            <span class="badge-role">👋 ${sessionScope.userName}</span>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/logout">Logout</a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item ms-3">
                            <a class="nav-link" href="/login">Login</a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>

<main class="container my-4">