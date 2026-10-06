<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="header.jsp" %>

<div class="container" style="max-width: 650px;">
    <h2 class="page-title">➕ Register New Agent</h2>

    <div class="form-card fade-in">
        <form action="/agents/add" method="post">
            <div class="mb-3">
                <label class="form-label">Agent ID</label>
                <input type="text" name="id" class="form-control" placeholder="AG-1005" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Full Name</label>
                <input type="text" name="name" class="form-control" placeholder="John Silva" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Email</label>
                <input type="email" name="email" class="form-control" placeholder="agent@example.com" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Password</label>
                <input type="password" name="password" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Specialization</label>
                <select name="specialization" class="form-select">
                    <option>Residential</option>
                    <option>Commercial</option>
                    <option>Land</option>
                    <option>Luxury</option>
                </select>
            </div>
            <div class="mb-3">
                <label class="form-label">Contact Number</label>
                <input type="text" name="contactNumber" class="form-control" placeholder="077-1234567" required>
            </div>

            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-success">💾 Save Agent</button>
                <a href="/agents/list" class="btn btn-outline-primary">Cancel</a>
            </div>
        </form>
    </div>
</div>

<%@ include file="footer.jsp" %>