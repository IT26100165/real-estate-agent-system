<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="header.jsp" %>

<div class="container py-5" style="max-width: 800px;">
    <h2 class="page-title mb-4">✏️ Edit Appointment</h2>

    <div class="form-card">
        <form action="/appointments/edit" method="post">
            <div class="mb-3"><label class="form-label">Appointment ID (Read Only)</label><input type="text" name="id" class="form-control" value="${appointment.id}" readonly></div>
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label">Client</label>
                    <select name="clientId" class="form-select" required>
                        <c:forEach var="cl" items="${clients}">
                            <option value="${cl.id}" ${cl.id == appointment.clientId ? 'selected' : ''}>${cl.id} — ${cl.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Agent</label>
                    <select name="agentId" class="form-select" required>
                        <c:forEach var="ag" items="${agents}">
                            <option value="${ag.id}" ${ag.id == appointment.agentId ? 'selected' : ''}>${ag.id} — ${ag.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 mb-3"><label class="form-label">Date</label><input type="date" name="date" class="form-control" value="${appointment.date}" required></div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Time Slot</label>
                    <select name="timeSlot" class="form-select">
                        <option ${appointment.timeSlot == '09:00 AM' ? 'selected' : ''}>09:00 AM</option>
                        <option ${appointment.timeSlot == '10:00 AM' ? 'selected' : ''}>10:00 AM</option>
                        <option ${appointment.timeSlot == '11:00 AM' ? 'selected' : ''}>11:00 AM</option>
                        <option ${appointment.timeSlot == '02:00 PM' ? 'selected' : ''}>02:00 PM</option>
                        <option ${appointment.timeSlot == '03:00 PM' ? 'selected' : ''}>03:00 PM</option>
                    </select>
                </div>
            </div>
            <div class="mb-3">
                <label class="form-label">Status</label>
                <select name="status" class="form-select">
                    <option value="Pending" ${appointment.status == 'Pending' ? 'selected' : ''}>Pending</option>
                    <option value="Confirmed" ${appointment.status == 'Confirmed' ? 'selected' : ''}>Confirmed</option>
                    <option value="Completed" ${appointment.status == 'Completed' ? 'selected' : ''}>Completed</option>
                    <option value="Cancelled" ${appointment.status == 'Cancelled' ? 'selected' : ''}>Cancelled</option>
                </select>
            </div>
            <div class="mb-3"><label class="form-label">Property Description</label><input type="text" name="propertyDescription" class="form-control" value="${appointment.propertyDescription}" required></div>
            <div class="mb-3"><label class="form-label">Notes</label><textarea name="notes" class="form-control" rows="2">${appointment.notes}</textarea></div>

            <div class="d-flex gap-2 mt-4">
                <button type="submit" class="btn btn-success">💾 Save Changes</button>
                <a href="/appointments/list" class="btn btn-outline-primary">Cancel</a>
            </div>
        </form>
    </div>
</div>
<%@ include file="footer.jsp" %>