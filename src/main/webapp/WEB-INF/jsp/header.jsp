<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EstateHub — Real Estate Agent Finder</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css">

    <link href="/css/style.css" rel="stylesheet">

    <style>
        .navbar-nav .nav-link {
            padding-left: 0.6rem !important;
            padding-right: 0.6rem !important;
            font-size: 0.85rem !important;
            font-weight: 500;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-custom sticky-top">
    <div class="container">
        <a class="navbar-brand" href="/">
            <span class="brand-mark"><i class="bi bi-buildings"></i></span> EstateHub
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navMenu">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navMenu">
            <ul class="navbar-nav ms-auto align-items-center">

                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <li class="nav-item"><a class="nav-link" href="/dashboard"><i class="bi bi-speedometer2 me-1"></i> Dashboard</a></li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item"><a class="nav-link" href="/">Home</a></li>
                    </c:otherwise>
                </c:choose>

                <c:if test="${sessionScope.role != 'AGENT'}">
                    <li class="nav-item"><a class="nav-link" href="/agents/list"><i class="bi bi-people me-1"></i> Agents</a></li>
                </c:if>

                <li class="nav-item"><a class="nav-link" href="/properties/list"><i class="bi bi-house me-1"></i> Properties</a></li>

                <c:if test="${not empty sessionScope.user}">
                    <li class="nav-item"><a class="nav-link" href="/appointments/list"><i class="bi bi-calendar-event me-1"></i> Appointments</a></li>
                    <li class="nav-item"><a class="nav-link" href="/reviews/list"><i class="bi bi-star me-1"></i> Reviews</a></li>
                </c:if>

                <c:if test="${sessionScope.role == 'ADMIN'}">
                    <li class="nav-item"><a class="nav-link" href="/clients/list"><i class="bi bi-person-badge me-1"></i> Clients</a></li>
                    <li class="nav-item"><a class="nav-link" href="/admins/list"><i class="bi bi-shield-lock me-1"></i> Admin</a></li>
                </c:if>

                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <li class="nav-item dropdown ms-2">
                            <a class="nav-link dropdown-toggle d-flex align-items-center gap-2" href="#" role="button" data-bs-toggle="dropdown">
                                <span class="user-avatar">${fn:substring(sessionScope.userName, 0, 1)}</span>
                                <span class="d-none d-xl-inline">${sessionScope.userName}</span>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end shadow">
                                <li><span class="dropdown-item-text small text-muted">Role: <strong>${sessionScope.role}</strong></span></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="/profile"><i class="bi bi-person me-2"></i>My Profile</a></li>
                                <li><a class="dropdown-item text-danger" href="/logout"><i class="bi bi-box-arrow-right me-2"></i>Logout</a></li>
                            </ul>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item ms-2">
                            <a class="nav-link" href="/login"><i class="bi bi-box-arrow-in-right me-1"></i> Login</a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>

<main>