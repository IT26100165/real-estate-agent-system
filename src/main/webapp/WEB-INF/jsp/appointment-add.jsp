<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="header.jsp" %>

<div class="container py-5" style="max-width: 800px;">
    <h2 class="page-title mb-4">📅 Book New Appointment</h2>
    <c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>

    <div class="form-card">
        <form action="/appointments/add" method="post">
            <div class="mb-3"><label class="form-label">Appointment ID</label><input type="text" name="id" class="form-control" required></div>
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label">Client</label>
                    <select name="clientId" class="form-select" required>
                        <option value="">-- Select Client --</option>
                        <c:forEach var="cl" items="${clients}"><option value="${cl.id}">${cl.id} — ${cl.name}</option></c:forEach>
                    </select>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Agent</label>
                    <select name="agentId" class="form-select" required>
                        <option value="">-- Select Agent --</option>
                        <c:forEach var="ag" items="${agents}"><option value="${ag.id}">${ag.id} — ${ag.name}</option></c:forEach>
                    </select>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 mb-3"><label class="form-label">Date</label><input type="date" name="date" class="form-control" required></div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Time Slot</label>
                    <select name="timeSlot" class="form-select"><option>09:00 AM</option><option>10:00 AM</option><option>11:00 AM</option><option>02:00 PM</option><option>03:00 PM</option></select>
                </div>
            </div>
            <div class="mb-3">
                <label class="form-label">Status</label>
                <select name="status" class="form-select"><option>Pending</option><option>Confirmed</option></select>
            </div>
            <div class="mb-3"><label class="form-label">Property Description</label><input type="text" name="propertyDescription" class="form-control" required></div>
            <div class="mb-3"><label class="form-label">Notes</label><textarea name="notes" class="form-control" rows="2"></textarea></div>

            <div class="d-flex gap-2 mt-4">
                <button type="submit" class="btn btn-success">💾 Book Appointment</button>
                <a href="/appointments/list" class="btn btn-outline-primary">Cancel</a>
            </div>
        </form>
    </div>
</div>
<%@ include file="footer.jsp" %>