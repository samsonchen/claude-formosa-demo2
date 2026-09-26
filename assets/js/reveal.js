/* 最低限度的進場淡入。prefers-reduced-motion 由 CSS 處理。 */
(function () {
  var els = document.querySelectorAll('.reveal');
  if (!els.length) return;
  if (!('IntersectionObserver' in window)) {
    for (var i = 0; i < els.length; i++) els[i].classList.add('in');
    return;
  }
  var io = new IntersectionObserver(function (entries) {
    entries.forEach(function (e) {
      if (e.isIntersecting) { e.target.classList.add('in'); io.unobserve(e.target); }
    });
  }, { rootMargin: '0px 0px -8% 0px', threshold: 0.05 });
  els.forEach(function (el) { io.observe(el); });

  /* 保險絲：任何原因導致觀察沒生效時，3 秒後一律顯示 */
  setTimeout(function () {
    for (var i = 0; i < els.length; i++) els[i].classList.add('in');
  }, 3000);
})();
