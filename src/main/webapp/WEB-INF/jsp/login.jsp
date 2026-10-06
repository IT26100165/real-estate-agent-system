<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="header.jsp" %>

<div class="container" style="max-width: 440px; margin-top: 40px;">
    <div class="card card-modern fade-in">
        <div class="card-body p-4">
            <h2 class="text-center mb-4">🔐 Welcome Back</h2>

            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <form action="/login" method="post">
                <div class="mb-3">
                    <label class="form-label">Email</label>
                    <input type="email" name="email" class="form-control" required autofocus>
                </div>
                <div class="mb-3">
                    <label class="form-label">Password</label>
                    <input type="password" name="password" class="form-control" required>
                </div>
                <button type="submit" class="btn btn-primary w-100">Login</button>
            </form>

            <hr>
            <p class="text-center mb-0 small">
                Don't have an account? <a href="/agents/add">Register as Agent</a>
            </p>
        </div>
    </div>

    <div class="alert alert-info mt-3 small">
        <strong>Test credentials:</strong><br>
        Email: <code>sarah@test.com</code><br>
        Password: <code>pass123</code>
    </div>
</div>

<%@ include file="footer.jsp" %>