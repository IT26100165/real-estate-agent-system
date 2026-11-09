<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
</main>

<footer class="footer-modern">
    <div class="container">
        <div class="d-flex flex-column flex-md-row justify-content-between align-items-center">
            <div class="mb-2 mb-md-0">
                <span class="fw-bold text-white"><i class="bi bi-buildings me-1"></i> EstateHub</span>
                <span class="text-muted mx-2">|</span>
                <span>Real Estate Agent Finder & Appointment System</span>
            </div>
            <div>
                &copy; 2026 Group G3 &middot; SE1020 Object-Oriented Programming &middot; SLIIT
            </div>
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<div id="toast-data" data-message="${message}" data-type="${toastType}" style="display: none;"></div>

<script>
    // 1. TOAST NOTIFICATIONS
    document.addEventListener("DOMContentLoaded", function() {
        const toastDiv = document.getElementById("toast-data");
        const message = toastDiv.getAttribute("data-message");
        const type = toastDiv.getAttribute("data-type");

        if (message && message.trim() !== "") {
            let bgColor = "#10b981";
            if (type === "error") bgColor = "#ef4444";
            if (type === "info") bgColor = "#3b82f6";

            Toastify({
                text: message,
                duration: 3500,
                close: true,
                gravity: "top",
                position: "right",
                stopOnFocus: true,
                style: { background: bgColor, borderRadius: "8px", fontWeight: "600", boxShadow: "0 10px 25px rgba(0,0,0,0.2)" }
            }).showToast();
        }
    });

    // 2. DATATABLES INITIALIZATION
    $(document).ready(function() {
        if ($('.table-modern').length > 0) {
            $('.table-modern').DataTable({
                "pageLength": 10,
                "lengthMenu": [[5, 10, 25, -1], [5, 10, 25, "All"]],
                "ordering": true,
                "language": {
                    "search": "",
                    "searchPlaceholder": "Search records...",
                    "lengthMenu": "Show _MENU_ entries",
                    "info": "Showing _START_ to _END_ of _TOTAL_ entries",
                    "paginate": {
                        "previous": "<i class='bi bi-chevron-left'></i>",
                        "next": "<i class='bi bi-chevron-right'></i>"
                    }
                }
            });
        }
    });
</script>
</body>
</html>