<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="header.jsp" %>

<div class="container" style="max-width: 750px;">
    <h2 class="page-title">➕ Add New Property</h2>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <div class="form-card fade-in">
        <form action="/properties/add" method="post">
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label">Property ID</label>
                    <input type="text" name="id" class="form-control" placeholder="PROP-4001" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Title</label>
                    <input type="text" name="title" class="form-control" placeholder="Luxury Apartment" required>
                </div>
            </div>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label">Location</label>
                    <input type="text" name="location" class="form-control" placeholder="Colombo 07" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Price (LKR)</label>
                    <input type="number" name="price" class="form-control" placeholder="25000000" required>
                </div>
            </div>

            <div class="row">
                <div class="col-md-4 mb-3">
                    <label class="form-label">Property Type</label>
                    <select name="propertyType" class="form-select">
                        <option>Apartment</option>
                        <option>House</option>
                        <option>Land</option>
                        <option>Commercial</option>
                        <option>Luxury</option>
                    </select>
                </div>
                <div class="col-md-4 mb-3">
                    <label class="form-label">Bedrooms</label>
                    <input type="number" name="bedrooms" class="form-control" value="0" min="0" required>
                </div>
                <div class="col-md-4 mb-3">
                    <label class="form-label">Bathrooms</label>
                    <input type="number" name="bathrooms" class="form-control" value="0" min="0" required>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label">Description</label>
                <textarea name="description" class="form-control" rows="3"
                          placeholder="Brief description of the property..." required></textarea>
            </div>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label">Listing Agent</label>
                    <select name="listingAgentId" class="form-select" required>
                        <option value="">-- Select Agent --</option>
                        <c:forEach var="ag" items="${agents}">
                            <option value="${ag.id}">${ag.id} — ${ag.name} (${ag.specialization})</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Availability Status</label>
                    <select name="availabilityStatus" class="form-select">
                        <option>Available</option>
                        <option>Sold</option>
                        <option>Rented</option>
                    </select>
                </div>
            </div>

            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-success">💾 Save Property</button>
                <a href="/properties/list" class="btn btn-outline-primary">Cancel</a>
            </div>
        </form>
    </div>
</div>

<%@ include file="footer.jsp" %>