<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="header.jsp" %>

<div class="container" style="max-width: 750px;">
    <h2 class="page-title">✏️ Edit Property</h2>

    <div class="form-card fade-in">
        <form action="/properties/edit" method="post">
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label">Property ID (read only)</label>
                    <input type="text" name="id" class="form-control" value="${property.id}" readonly>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Title</label>
                    <input type="text" name="title" class="form-control" value="${property.title}" required>
                </div>
            </div>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label">Location</label>
                    <input type="text" name="location" class="form-control" value="${property.location}" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Price (LKR)</label>
                    <input type="number" name="price" class="form-control" value="${property.price}" required>
                </div>
            </div>

            <div class="row">
                <div class="col-md-4 mb-3">
                    <label class="form-label">Type</label>
                    <select name="propertyType" class="form-select">
                        <option value="Apartment" ${property.propertyType == 'Apartment' ? 'selected' : ''}>Apartment</option>
                        <option value="House" ${property.propertyType == 'House' ? 'selected' : ''}>House</option>
                        <option value="Land" ${property.propertyType == 'Land' ? 'selected' : ''}>Land</option>
                        <option value="Commercial" ${property.propertyType == 'Commercial' ? 'selected' : ''}>Commercial</option>
                        <option value="Luxury" ${property.propertyType == 'Luxury' ? 'selected' : ''}>Luxury</option>
                    </select>
                </div>
                <div class="col-md-4 mb-3">
                    <label class="form-label">Bedrooms</label>
                    <input type="number" name="bedrooms" class="form-control" value="${property.bedrooms}" min="0" required>
                </div>
                <div class="col-md-4 mb-3">
                    <label class="form-label">Bathrooms</label>
                    <input type="number" name="bathrooms" class="form-control" value="${property.bathrooms}" min="0" required>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label">Description</label>
                <textarea name="description" class="form-control" rows="3" required>${property.description}</textarea>
            </div>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label">Listing Agent</label>
                    <select name="listingAgentId" class="form-select" required>
                        <c:forEach var="ag" items="${agents}">
                            <option value="${ag.id}" ${ag.id == property.listingAgentId ? 'selected' : ''}>
                                ${ag.id} — ${ag.name} (${ag.specialization})
                            </option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Availability Status</label>
                    <select name="availabilityStatus" class="form-select">
                        <option value="Available" ${property.availabilityStatus == 'Available' ? 'selected' : ''}>Available</option>
                        <option value="Sold" ${property.availabilityStatus == 'Sold' ? 'selected' : ''}>Sold</option>
                        <option value="Rented" ${property.availabilityStatus == 'Rented' ? 'selected' : ''}>Rented</option>
                    </select>
                </div>
            </div>

            <input type="hidden" name="listedDate" value="${property.listedDate}">

            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-success">💾 Save Changes</button>
                <a href="/properties/list" class="btn btn-outline-primary">Cancel</a>
            </div>
        </form>
    </div>
</div>

<%@ include file="footer.jsp" %>