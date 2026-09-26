/* 語言切換。首次繪製前的判定在 <head> 的 inline script，這裡只處理互動與同步。 */
(function () {
  var el = document.documentElement;

  function syncMeta(lang) {
    var t = el.getAttribute('data-title-' + lang);
    var d = el.getAttribute('data-desc-' + lang);
    if (t) document.title = t;
    var m = document.querySelector('meta[name="description"]');
    if (m && d) m.setAttribute('content', d);
    el.setAttribute('lang', lang === 'zh' ? 'zh-Hant' : 'en');
  }

  function syncButtons(lang) {
    var btns = document.querySelectorAll('[data-setlang]');
    for (var i = 0; i < btns.length; i++) {
      var on = btns[i].getAttribute('data-setlang') === lang;
      btns[i].setAttribute('aria-pressed', on ? 'true' : 'false');
    }
  }

  function apply(lang, pushUrl) {
    el.setAttribute('data-lang', lang);
    syncMeta(lang);
    syncButtons(lang);
    try { localStorage.setItem('cf-lang', lang); } catch (e) {}
    if (pushUrl && window.history && history.replaceState) {
      var u = new URL(location.href);
      u.searchParams.set('lang', lang);
      history.replaceState(null, '', u);
    }
  }

  var current = el.getAttribute('data-lang') || 'zh';
  syncMeta(current);
  syncButtons(current);

  document.addEventListener('click', function (e) {
    var b = e.target.closest ? e.target.closest('[data-setlang]') : null;
    if (!b) return;
    apply(b.getAttribute('data-setlang'), true);
  });

  /* 內部連結帶上目前語言，讓活動頁之間的瀏覽不會跳回預設語言 */
  document.addEventListener('click', function (e) {
    var a = e.target.closest ? e.target.closest('a[href]') : null;
    if (!a) return;
    var href = a.getAttribute('href');
    if (!href || href.charAt(0) === '#') return;
    if (a.host !== location.host) return;
    var lang = el.getAttribute('data-lang');
    try {
      var u = new URL(a.href);
      if (!u.searchParams.has('lang')) {
        u.searchParams.set('lang', lang);
        a.href = u.toString();
      }
    } catch (err) {}
  });
})();
