</main>

<footer class="footer-modern">
    <div class="container">
        <p class="mb-1"><strong>EstateHub</strong> — Real Estate Agent Finder & Appointment System</p>
        <p class="mb-0">© 2026 Group G3 · SE1020 Object-Oriented Programming · SLIIT</p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- Hidden div to pass flash attributes to JS -->
<div id="toast-data"
     data-message="${message}"
     data-type="${toastType}"
     style="display: none;">
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        const toastDiv = document.getElementById("toast-data");
        const message = toastDiv.getAttribute("data-message");
        const type = toastDiv.getAttribute("data-type");

        if (message && message.trim() !== "") {
            let bgColor = "#10b981"; // Default green for success
            if (type === "error") bgColor = "#ef4444"; // Red for error
            if (type === "info") bgColor = "#3b82f6"; // Blue for info

            Toastify({
                text: message,
                duration: 3500,
                close: true,
                gravity: "top", // `top` or `bottom`
                position: "right", // `left`, `center` or `right`
                stopOnFocus: true, // Prevents dismissing of toast on hover
                style: {
                    background: bgColor,
                    borderRadius: "8px",
                    fontWeight: "600",
                    boxShadow: "0 10px 25px rgba(0,0,0,0.2)"
                }
            }).showToast();
        }
    });
</script>
</body>
</html>