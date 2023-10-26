document.addEventListener('DOMContentLoaded', function() {

    const mobileMenuButton = document.querySelector('#mobile-menu');
    const navList = document.querySelector('.nav-list');
    const closeButton = document.querySelector('.close-menu');
    const loadingScreen = document.querySelector(".loading-screen");


    document.body.classList.add('loading-active');

    setTimeout(function() {
        loadingScreen.style.display = "none";
        document.body.classList.remove('loading-active');
    }, 2000);

    mobileMenuButton.addEventListener('click', () => navList.classList.add('active'));
    closeButton.addEventListener('click', () => navList.classList.remove('active'));

    const backToTopButton = document.getElementById('backToTop');

    window.addEventListener('scroll', () => {
        backToTopButton.style.display = window.pageYOffset > 300 ? 'block' : 'none';
    });

    backToTopButton.addEventListener('click', () => {
        window.scrollTo({
            top: 0,
            behavior: 'smooth'
        });
    });
});
