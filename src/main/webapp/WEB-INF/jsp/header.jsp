<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Real Estate Agent Finder</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="/">🏠 Real Estate Agent Finder</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navMenu">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navMenu">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link" href="/">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="/agents/list">Agents</a></li>
                <li class="nav-item"><a class="nav-link" href="/clients/list">Clients</a></li>
                <li class="nav-item"><a class="nav-link" href="/appointments/list">Appointments</a></li>
                <li class="nav-item"><a class="nav-link" href="/properties/list">Properties</a></li>
                <li class="nav-item"><a class="nav-link" href="/reviews/list">Reviews</a></li>
                <li class="nav-item"><a class="nav-link" href="/admins/list">Admin</a></li>
            </ul>
        </div>
    </div>
</nav>
<main class="container mt-4">