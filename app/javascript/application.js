// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@rails/ujs"
document.addEventListener('DOMContentLoaded', () => {
  const searchInput = document.getElementById('search-input');

  if (searchInput) {
    searchInput.addEventListener('input', () => {
      const form = document.getElementById('search-form');
      Rails.fire(form, 'submit');
    });
  }
});
