document.addEventListener('DOMContentLoaded', () => {
    const searchInput = document.getElementById('searchInput');
    const categoryButtons = document.querySelectorAll('.filter-btn');
    const courseItems = document.querySelectorAll('.course-item');
    const noResults = document.getElementById('noResults');

    let currentCategory = 'todos';
    let currentSearchTerm = '';

    // Función para filtrar cursos por búsqueda y categoría
    function filterCourses() {
        let visibleCount = 0;

        courseItems.forEach(item => {
            const title = item.getAttribute('data-title') || '';
            const category = item.getAttribute('data-category') || '';

            // Aseguramos que ambas variables existan antes de aplicar toLowerCase()
            const matchesCategory = (currentCategory === 'todos' || (category && category.toLowerCase() === currentCategory.toLowerCase()));
            const matchesSearch = title.includes(currentSearchTerm);

            if (matchesCategory && matchesSearch) {
                item.classList.remove('d-none');
                visibleCount++;
            } else {
                item.classList.add('d-none');
            }
        });

        if (visibleCount === 0 && courseItems.length > 0) {
            noResults.classList.remove('d-none');
        } else {
            noResults.classList.add('d-none');
        }
    }

    // Evento para Búsqueda por texto
    if (searchInput) {
        searchInput.addEventListener('input', (e) => {
            currentSearchTerm = e.target.value.toLowerCase().trim();
            filterCourses();
        });
    }

    // Evento para Filtros por Categoría
    categoryButtons.forEach(button => {
        button.addEventListener('click', () => {
            categoryButtons.forEach(btn => {
                btn.classList.remove('btn-primary', 'active');
                btn.classList.add('btn-outline-secondary');
            });

            button.classList.remove('btn-outline-secondary');
            button.classList.add('btn-primary', 'active');

            currentCategory = button.getAttribute('data-filter');
            filterCourses();
        });
    });
});