<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="header.jsp" %>

<div class="container py-5" style="max-width: 700px;">
    <h2 class="page-title mb-4">✏️ Edit Agent</h2>

    <div class="form-card">
        <form action="/agents/edit" method="post">
            <div class="mb-3"><label class="form-label">Agent ID (Read Only)</label><input type="text" name="id" class="form-control" value="${agent.id}" readonly></div>
            <div class="mb-3"><label class="form-label">Full Name</label><input type="text" name="name" class="form-control" value="${agent.name}" required></div>
            <div class="mb-3"><label class="form-label">Email</label><input type="email" name="email" class="form-control" value="${agent.email}" required></div>
            <div class="mb-3"><label class="form-label">Password</label><input type="text" name="password" class="form-control" value="${agent.password}" required></div>
            <div class="mb-3">
                <label class="form-label">Specialization</label>
                <select name="specialization" class="form-select">
                    <option value="Residential" ${agent.specialization == 'Residential' ? 'selected' : ''}>Residential</option>
                    <option value="Commercial" ${agent.specialization == 'Commercial' ? 'selected' : ''}>Commercial</option>
                    <option value="Land" ${agent.specialization == 'Land' ? 'selected' : ''}>Land</option>
                    <option value="Luxury" ${agent.specialization == 'Luxury' ? 'selected' : ''}>Luxury</option>
                </select>
            </div>
            <div class="mb-3"><label class="form-label">Contact Number</label><input type="text" name="contactNumber" class="form-control" value="${agent.contactNumber}" required></div>

            <div class="d-flex gap-2 mt-4">
                <button type="submit" class="btn btn-success">💾 Save Changes</button>
                <a href="/agents/list" class="btn btn-outline-primary">Cancel</a>
            </div>
        </form>
    </div>
</div>
<%@ include file="footer.jsp" %>