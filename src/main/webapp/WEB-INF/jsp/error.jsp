<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="header.jsp" %>

<div class="container py-5 text-center" style="min-height: 60vh;">
    <div style="font-size: 5rem; margin-bottom: 1rem;">🚧</div>
    <h1 class="page-title justify-content-center" style="font-size: 2rem;">${errorTitle}</h1>
    <p class="text-muted mb-4" style="font-size: 1.1rem;">${errorMessage}</p>

    <div class="d-flex justify-content-center gap-3">
        <a href="/dashboard" class="btn btn-primary">Go to Dashboard</a>
        <a href="/" class="btn btn-outline-primary">Go to Homepage</a>
    </div>
</div>

<%@ include file="footer.jsp" %>