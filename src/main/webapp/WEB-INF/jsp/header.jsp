<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
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
                        <li class="nav-item dropdown ms-3">
                            <a class="nav-link dropdown-toggle d-flex align-items-center gap-2" href="#" data-bs-toggle="dropdown">
                                <span class="user-avatar">${fn:substring(sessionScope.userName, 0, 1)}</span>
                                <span>${sessionScope.userName}</span>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li><span class="dropdown-item-text small text-muted">Role: ${sessionScope.role}</span></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item text-danger" href="/logout">Logout</a></li>
                            </ul>
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