<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="header.jsp" %>

<div class="container" style="max-width: 650px;">
    <h2 class="page-title">✏️ Edit Client</h2>

    <div class="form-card fade-in">
        <form action="/clients/edit" method="post">
            <div class="mb-3">
                <label class="form-label">Client ID (cannot be changed)</label>
                <input type="text" name="id" class="form-control" value="${client.id}" readonly>
            </div>
            <div class="mb-3">
                <label class="form-label">Full Name</label>
                <input type="text" name="name" class="form-control" value="${client.name}" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Email</label>
                <input type="email" name="email" class="form-control" value="${client.email}" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Password</label>
                <input type="text" name="password" class="form-control" value="${client.password}" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Phone Number</label>
                <input type="text" name="phoneNumber" class="form-control" value="${client.phoneNumber}" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Address</label>
                <input type="text" name="address" class="form-control" value="${client.address}" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Property Preference</label>
                <select name="propertyPreference" class="form-select">
                    <option value="Apartment" ${client.propertyPreference == 'Apartment' ? 'selected' : ''}>Apartment</option>
                    <option value="House" ${client.propertyPreference == 'House' ? 'selected' : ''}>House</option>
                    <option value="Land" ${client.propertyPreference == 'Land' ? 'selected' : ''}>Land</option>
                    <option value="Commercial" ${client.propertyPreference == 'Commercial' ? 'selected' : ''}>Commercial</option>
                    <option value="Luxury" ${client.propertyPreference == 'Luxury' ? 'selected' : ''}>Luxury</option>
                </select>
            </div>
            <input type="hidden" name="registrationDate" value="${client.registrationDate}">

            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-success">💾 Save Changes</button>
                <a href="/clients/list" class="btn btn-outline-primary">Cancel</a>
            </div>
        </form>
    </div>
</div>

<%@ include file="footer.jsp" %>