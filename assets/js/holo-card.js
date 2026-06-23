/* Holo-card interactive tilt 3D + reflet conique au pointeur
   Activé sur les éléments [data-holo] (cartes home v6, hero featured, article-hero).
   Respect prefers-reduced-motion. */
(function () {
  if (window.matchMedia('(prefers-reduced-motion: reduce)').matches) return;

  function init() {
    var cards = document.querySelectorAll('[data-holo]');
    if (!cards.length) return;

    cards.forEach(function (card) {
      var isMini = card.classList.contains('holo-card--mini');
      var isHero = card.classList.contains('hero__card');
      var maxTilt = isHero ? 14 : (isMini ? 10 : 12);
      var maxLift = isHero ? 10 : (isMini ? 7 : 8);
      var rect, raf;

      function update(e) {
        if (!rect) rect = card.getBoundingClientRect();
        var x = (e.clientX - rect.left) / rect.width;
        var y = (e.clientY - rect.top)  / rect.height;
        if (raf) cancelAnimationFrame(raf);
        raf = requestAnimationFrame(function () {
          var rx = (x - 0.5) * maxTilt;
          var ry = (0.5 - y) * maxLift;
          card.style.setProperty('--mx', (x * 100) + '%');
          card.style.setProperty('--my', (y * 100) + '%');
          card.style.setProperty('--rx', rx + 'deg');
          card.style.setProperty('--ry', ry + 'deg');
          card.style.setProperty('--holo-strength', '1');
        });
      }
      function reset() {
        rect = null;
        card.style.setProperty('--rx', '0deg');
        card.style.setProperty('--ry', '0deg');
        card.style.setProperty('--holo-strength', '0');
      }
      card.addEventListener('mouseenter', function () { rect = card.getBoundingClientRect(); });
      card.addEventListener('mousemove', update);
      card.addEventListener('mouseleave', reset);
      card.addEventListener('touchmove', function (e) {
        if (e.touches.length) update(e.touches[0]);
      }, { passive: true });
      card.addEventListener('touchend', reset);
    });
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }
})();
