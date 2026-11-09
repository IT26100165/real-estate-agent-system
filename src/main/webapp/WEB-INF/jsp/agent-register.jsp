<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="header.jsp" %>

<div class="container py-5" style="max-width: 700px;">
    <div class="text-center mb-4">
        <h2 class="fw-bold"><i class="bi bi-person-badge text-primary me-2"></i>Become an Agent</h2>
        <p class="text-muted">Join EstateHub to list properties and manage client appointments.</p>
    </div>

    <div class="card module-card p-4 fade-in shadow-sm">
        <form action="/agents/register" method="post">
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label">Agent ID</label>
                    <input type="text" name="id" class="form-control" placeholder="AG-1008" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Full Name</label>
                    <input type="text" name="name" class="form-control" placeholder="Jane Doe" required>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label">Email Address</label>
                <input type="email" name="email" class="form-control" placeholder="jane@example.com" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Password</label>
                <input type="password" name="password" class="form-control" placeholder="••••••••" required>
            </div>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label">Specialization</label>
                    <select name="specialization" class="form-select">
                        <option>Residential</option>
                        <option>Commercial</option>
                        <option>Land</option>
                        <option>Luxury</option>
                    </select>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Contact Number</label>
                    <input type="text" name="contactNumber" class="form-control" placeholder="077-1234567" required>
                </div>
            </div>

            <button type="submit" class="btn btn-primary w-100 py-2 mt-3">Register as Agent</button>
        </form>

        <hr class="my-4 text-muted">

        <p class="text-center mb-0 small text-muted">
            Already have an account? <a href="/login" class="text-decoration-none fw-bold">Sign In</a>
        </p>
    </div>
</div>

<%@ include file="footer.jsp" %>