<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="header.jsp" %>

<div class="container py-5" style="max-width: 700px;">
    <h2 class="page-title mb-4">⭐ Submit a Review</h2>
    <c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>

    <div class="form-card">
        <form action="/reviews/add" method="post">
            <div class="mb-3"><label class="form-label">Review ID</label><input type="text" name="id" class="form-control" required></div>
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label">Client (Reviewer)</label>
                    <select name="clientId" class="form-select" required>
                        <option value="">-- Select Client --</option>
                        <c:forEach var="cl" items="${clients}"><option value="${cl.id}">${cl.id} — ${cl.name}</option></c:forEach>
                    </select>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Agent (Being Reviewed)</label>
                    <select name="agentId" class="form-select" required>
                        <option value="">-- Select Agent --</option>
                        <c:forEach var="ag" items="${agents}"><option value="${ag.id}">${ag.id} — ${ag.name}</option></c:forEach>
                    </select>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label">Rating</label>
                    <select name="rating" class="form-select" required>
                        <option value="5">⭐⭐⭐⭐⭐ (5) - Excellent</option>
                        <option value="4">⭐⭐⭐⭐ (4) - Good</option>
                        <option value="3">⭐⭐⭐ (3) - Average</option>
                        <option value="2">⭐⭐ (2) - Poor</option>
                        <option value="1">⭐ (1) - Very Poor</option>
                    </select>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Status</label>
                    <select name="moderationStatus" class="form-select"><option>Pending</option><option>Approved</option></select>
                </div>
            </div>
            <div class="mb-3"><label class="form-label">Comment</label><textarea name="comment" class="form-control" rows="3" placeholder= "Tell us about your experience..." required></textarea></div>

            <div class="d-flex gap-2 mt-4">
                <button type="submit" class="btn btn-success">💾 Submit Review</button>
                <a href="/reviews/list" class="btn btn-outline-primary">Cancel</a>
            </div>
        </form>
    </div>
</div>
<%@ include file="footer.jsp" %>