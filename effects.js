<script>
document.addEventListener('DOMContentLoaded', () => {
  // Scroll reveal via Intersection Observer
  const revealEls = document.querySelectorAll('h2, .service-card, .g-col-md-4, .g-col-md-6, .callout');
  revealEls.forEach(el => el.classList.add('reveal'));

  const observer = new IntersectionObserver((entries) => {
    entries.forEach(e => { if (e.isIntersecting) e.target.classList.add('visible'); });
  }, { threshold: 0.15 });

  revealEls.forEach(el => observer.observe(el));

  // Floating pixel decorations
  const colors = ['#7c4dff', '#00e5ff', '#7c4dff', '#00e5ff', '#b388ff', '#18ffff'];
  for (let i = 0; i < 6; i++) {
    const px = document.createElement('span');
    px.className = 'floating-pixel';
    px.style.background = colors[i];
    px.style.top = Math.random() * 90 + 5 + 'vh';
    px.style.left = Math.random() * 90 + 5 + 'vw';
    px.style.animationDelay = (i * 2) + 's';
    px.style.animationDuration = (10 + Math.random() * 8) + 's';
    document.body.appendChild(px);
  }
});
</script>
