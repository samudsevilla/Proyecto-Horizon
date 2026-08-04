document.addEventListener('DOMContentLoaded', () => {
    // 1. Obtener todas las cabeceras de los módulos
    const accordionHeaders = document.querySelectorAll('.accordion-header');

    accordionHeaders.forEach(header => {
        header.addEventListener('click', () => {
            const currentItem = header.parentElement;
            
            // Alternar estado (abrir/cerrar) del módulo cliqueado
            currentItem.classList.toggle('active');
        });
    });

    // 2. Mantener abierto automáticamente el módulo que contiene la lección activa
    const activeLesson = document.querySelector('.lesson-item.active');
    if (activeLesson) {
        const parentModule = activeLesson.closest('.accordion-item');
        if (parentModule) {
            parentModule.classList.add('active');
        }
    }
});