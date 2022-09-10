import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  themeToggleDarkIcon = "";
  themeToggleLightIcon = "";
  themeToggleDarkText = "";
  themeToggleLightText = "";

  connect() {

    this.themeToggleDarkIcon = document.getElementById('theme-toggle-dark-icon');
    this.themeToggleLightIcon = document.getElementById('theme-toggle-light-icon');

    this.themeToggleDarkText = document.getElementById('theme-toggle-dark-text');
    this.themeToggleLightText = document.getElementById('theme-toggle-light-text');

    // Change the icons inside the button based on previous settings
    if (localStorage.getItem('color-theme') === 'dark' || (!('color-theme' in localStorage) && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
      this.themeToggleLightIcon.classList.remove('hidden');
      this.themeToggleLightText.classList.remove('hidden');
    } else {
      this.themeToggleDarkIcon.classList.remove('hidden');
      this.themeToggleDarkText.classList.remove('hidden');
    }
  }

  toggle() {
    this.themeToggleDarkIcon.classList.toggle('hidden');
    this.themeToggleLightIcon.classList.toggle('hidden');
    this.themeToggleDarkText.classList.toggle('hidden');
    this.themeToggleLightText.classList.toggle('hidden');

    // if set via local storage previously
    if (localStorage.getItem('color-theme')) {
      if (localStorage.getItem('color-theme') === 'light') {
        document.documentElement.classList.add('dark');
        localStorage.setItem('color-theme', 'dark');
      } else {
        document.documentElement.classList.remove('dark');
        localStorage.setItem('color-theme', 'light');
      }

      // if NOT set via local storage previously
    } else {
      if (document.documentElement.classList.contains('dark')) {
        document.documentElement.classList.remove('dark');
        localStorage.setItem('color-theme', 'light');
      } else {
        document.documentElement.classList.add('dark');
        localStorage.setItem('color-theme', 'dark');
      }
    }
  }
}
