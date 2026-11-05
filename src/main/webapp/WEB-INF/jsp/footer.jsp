</main>

<footer class="footer-modern">
    <div class="container">
        <p class="mb-1"><strong>EstateHub</strong> — Real Estate Agent Finder & Appointment System</p>
        <p class="mb-0">© 2026 Group G3 · SE1020 Object-Oriented Programming · SLIIT</p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- jQuery (Required for DataTables) -->
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<!-- DataTables Core & Bootstrap 5 Integration -->
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>
<!-- Toastify JS -->
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
<!-- Chart.js (Required for Dashboards) -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<!-- Hidden div to pass flash attributes to JS -->
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