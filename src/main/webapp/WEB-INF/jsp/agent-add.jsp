<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Agent</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4" style="max-width: 600px;">
    <h2>Register New Agent</h2>

    <form action="/agents/add" method="post">
        <div class="mb-3">
            <label class="form-label">Agent ID</label>
            <input type="text" name="id" class="form-control" placeholder="AG-1005" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Full Name</label>
            <input type="text" name="name" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Email</label>
            <input type="email" name="email" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Password</label>
            <input type="password" name="password" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Specialization</label>
            <select name="specialization" class="form-select">
                <option>Residential</option>
                <option>Commercial</option>
                <option>Land</option>
                <option>Luxury</option>
            </select>
        </div>
        <div class="mb-3">
            <label class="form-label">Contact Number</label>
            <input type="text" name="contactNumber" class="form-control" placeholder="077-1234567" required>
        </div>

        <button type="submit" class="btn btn-success">Save Agent</button>
        <a href="/agents/list" class="btn btn-secondary">Cancel</a>
    </form>
</div>
</body>
</html>