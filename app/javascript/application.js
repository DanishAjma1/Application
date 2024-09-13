// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener('DOMContentLoaded', () => {
  const searchInput = document.getElementById('search-input');
  const searchForm = document.getElementById('search-form');

  if (searchInput) {
    searchInput.addEventListener('input', () => {
      const query = searchInput.value;

      // Fetch the search results for both projects and bugs
      fetch(`${searchForm.action}?query=${query}`, {
        headers: {
          'Accept': 'text/html' // Expect HTML response
        }
      })
      .then(response => response.text())
      .then(html => {
        const parser = new DOMParser();
        const doc = parser.parseFromString(html, 'text/html');

        // Update Projects Table
        const newProjectsTableBody = doc.querySelector('#projects-table-body');
        const projectsTableBody = document.getElementById('projects-table-body');
        if (projectsTableBody && newProjectsTableBody) {
          projectsTableBody.innerHTML = newProjectsTableBody.innerHTML; // Update projects table body
        }

        // Update Bugs Table
        const newBugsTableBody = doc.querySelector('#bugs-table-body');
        const bugsTableBody = document.getElementById('bugs-table-body');
        if (bugsTableBody && newBugsTableBody) {
          bugsTableBody.innerHTML = newBugsTableBody.innerHTML; // Update bugs table body
        }
      })
      .catch(error => console.error('Error:', error));
    });
  }
});
