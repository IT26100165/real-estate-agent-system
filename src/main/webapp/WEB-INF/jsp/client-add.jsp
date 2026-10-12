<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="header.jsp" %>

<div class="container" style="max-width: 650px;">
    <h2 class="page-title">➕ Register New Client</h2>

    <div class="form-card fade-in">
        <form action="/clients/add" method="post">
            <div class="mb-3">
                <label class="form-label">Client ID</label>
                <input type="text" name="id" class="form-control" placeholder="CL-2001" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Full Name</label>
                <input type="text" name="name" class="form-control" placeholder="Michael Perera" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Email</label>
                <input type="email" name="email" class="form-control" placeholder="client@example.com" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Password</label>
                <input type="password" name="password" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Phone Number</label>
                <input type="text" name="phoneNumber" class="form-control" placeholder="077-1234567" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Address</label>
                <input type="text" name="address" class="form-control" placeholder="Colombo" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Property Preference</label>
                <select name="propertyPreference" class="form-select">
                    <option>Apartment</option>
                    <option>House</option>
                    <option>Land</option>
                    <option>Commercial</option>
                    <option>Luxury</option>
                </select>
            </div>

            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-success">💾 Save Client</button>
                <a href="/clients/list" class="btn btn-outline-primary">Cancel</a>
            </div>
        </form>
    </div>
</div>

<%@ include file="footer.jsp" %>