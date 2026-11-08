<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="header.jsp" %>

<div class="container d-flex justify-content-center align-items-center" style="min-height: 75vh;">
    <div class="card module-card p-4 fade-in" style="max-width: 420px; width: 100%;">
        <div class="text-center mb-4">
            <div class="brand-mark mx-auto mb-3" style="width: 48px; height: 48px; font-size: 1.5rem;">
                <i class="bi bi-buildings"></i>
            </div>
            <h3 class="fw-bold">Welcome Back</h3>
            <p class="text-muted small">Sign in to access your dashboard.</p>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger py-2 small border-0"><i class="bi bi-exclamation-triangle-fill me-2"></i>${error}</div>
        </c:if>

        <form action="/login" method="post">
            <div class="mb-3">
                <label class="form-label">Email Address</label>
                <div class="input-group">
                    <span class="input-group-text bg-light border-end-0"><i class="bi bi-envelope text-muted"></i></span>
                    <input type="email" name="email" class="form-control border-start-0 ps-0" placeholder="name@example.com" required autofocus>
                </div>
            </div>
            <div class="mb-4">
                <label class="form-label">Password</label>
                <div class="input-group">
                    <span class="input-group-text bg-light border-end-0"><i class="bi bi-lock text-muted"></i></span>
                    <input type="password" name="password" class="form-control border-start-0 ps-0" placeholder="••••••••" required>
                </div>
            </div>
            <button type="submit" class="btn btn-primary w-100 py-2">Sign In</button>
        </form>

        <hr class="my-4 text-muted">

        <p class="text-center mb-0 small text-muted">
            Don't have an account? <a href="/agents/add" class="text-decoration-none fw-bold">Register as Agent</a>
        </p>
    </div>
</div>

<%@ include file="footer.jsp" %>