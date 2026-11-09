<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="header.jsp" %>

<div class="container py-5" style="max-width: 700px;">
    <h2 class="page-title mb-4"><i class="bi bi-pencil-square text-primary me-2"></i>Edit Review</h2>

    <div class="form-card fade-in shadow-sm">
        <form action="/reviews/edit" method="post">
            <div class="mb-3">
                <label class="form-label">Review ID (Read Only)</label>
                <input type="text" name="id" class="form-control bg-light" value="${review.id}" readonly>
            </div>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label">Client</label>
                    <select name="clientId" class="form-select" required>
                        <c:forEach var="cl" items="${clients}">
                            <option value="${cl.id}" ${cl.id == review.clientId ? 'selected' : ''}>${cl.id} — ${cl.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Agent</label>
                    <select name="agentId" class="form-select" required>
                        <c:forEach var="ag" items="${agents}">
                            <option value="${ag.id}" ${ag.id == review.agentId ? 'selected' : ''}>${ag.id} — ${ag.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label">Rating</label>
                    <select name="rating" class="form-select" required>
                        <option value="5" ${review.rating == 5 ? 'selected' : ''}>⭐⭐⭐⭐⭐ (5)</option>
                        <option value="4" ${review.rating == 4 ? 'selected' : ''}>⭐⭐⭐⭐ (4)</option>
                        <option value="3" ${review.rating == 3 ? 'selected' : ''}>⭐⭐⭐ (3)</option>
                        <option value="2" ${review.rating == 2 ? 'selected' : ''}>⭐⭐ (2)</option>
                        <option value="1" ${review.rating == 1 ? 'selected' : ''}>⭐ (1)</option>
                    </select>
                </div>

                <%-- ONLY SHOW STATUS DROPDOWN TO FULL-ACCESS ADMINS --%>
                <c:if test="${sessionScope.role == 'ADMIN' && sessionScope.adminPermissions == 'FULL_ACCESS'}">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Moderation Status</label>
                        <select name="moderationStatus" class="form-select">
                            <option value="Pending" ${review.moderationStatus == 'Pending' ? 'selected' : ''}>Pending</option>
                            <option value="Approved" ${review.moderationStatus == 'Approved' ? 'selected' : ''}>Approved</option>
                            <option value="Rejected" ${review.moderationStatus == 'Rejected' ? 'selected' : ''}>Rejected</option>
                        </select>
                    </div>
                </c:if>
            </div>

            <div class="mb-4">
                <label class="form-label">Comment</label>
                <textarea name="comment" class="form-control" rows="4" required>${review.comment}</textarea>
            </div>

            <input type="hidden" name="reviewDate" value="${review.reviewDate}">

            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-success"><i class="bi bi-save me-1"></i> Save Changes</button>
                <a href="/reviews/list" class="btn btn-outline-primary">Cancel</a>
            </div>
        </form>
    </div>
</div>

<%@ include file="footer.jsp" %>