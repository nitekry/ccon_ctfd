// CTFd Terminal Theme - Main JS
import "../scss/main.scss";

// Terminal typing effect for hero text
document.addEventListener("DOMContentLoaded", () => {
  // Add terminal cursor blink to hero headings
  const heroHeadings = document.querySelectorAll(".ctf-header h1, .jumbotron h1");
  heroHeadings.forEach((el) => {
    el.classList.add("cursor-blink");
  });

  // Add subtle glow pulse to nav brand
  const brand = document.querySelector(".navbar-brand");
  if (brand) {
    brand.classList.add("text-glow");
  }

  // Random boot-up flicker on page load
  const body = document.body;
  body.style.opacity = "0";
  setTimeout(() => {
    body.style.transition = "opacity 0.1s ease";
    body.style.opacity = "1";
  }, 50);
  setTimeout(() => {
    body.style.transition = "opacity 0.05s ease";
    body.style.opacity = "0.97";
  }, 150);
  setTimeout(() => {
    body.style.transition = "opacity 0.1s ease";
    body.style.opacity = "1";
  }, 200);
});
