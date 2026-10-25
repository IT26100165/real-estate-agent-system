<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="header.jsp" %>

<div class="container py-5" style="max-width: 700px;">
    <h2 class="page-title mb-4">➕ Register New Client</h2>
    <c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>

    <div class="form-card">
        <form action="/clients/add" method="post">
            <div class="mb-3"><label class="form-label">Client ID</label><input type="text" name="id" class="form-control" required></div>
            <div class="mb-3"><label class="form-label">Full Name</label><input type="text" name="name" class="form-control" required></div>
            <div class="mb-3"><label class="form-label">Email</label><input type="email" name="email" class="form-control" required></div>
            <div class="mb-3"><label class="form-label">Password</label><input type="password" name="password" class="form-control" required></div>
            <div class="mb-3"><label class="form-label">Phone Number</label><input type="text" name="phoneNumber" class="form-control" required></div>
            <div class="mb-3"><label class="form-label">Address</label><input type="text" name="address" class="form-control" required></div>
            <div class="mb-3">
                <label class="form-label">Property Preference</label>
                <select name="propertyPreference" class="form-select">
                    <option>Apartment</option><option>House</option><option>Land</option><option>Commercial</option><option>Luxury</option>
                </select>
            </div>
            <div class="d-flex gap-2 mt-4">
                <button type="submit" class="btn btn-success">💾 Save Client</button>
                <a href="/clients/list" class="btn btn-outline-primary">Cancel</a>
            </div>
        </form>
    </div>
</div>
<%@ include file="footer.jsp" %>