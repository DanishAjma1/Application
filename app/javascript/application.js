// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

// Wait for the DOM to be fully loaded
document.addEventListener('DOMContentLoaded', () => {
  const bugsearchInput = document.getElementById('bug-search-input');

    const projectsearchInput = document.getElementById('project-search-input');

  // Add an event listener for input changes
  if (projectsearchInput) {
    projectsearchInput.addEventListener('input', () => {
      const query = projectsearchInput.value;

      // Send an AJAX request
      fetch(`/projects.json?query=${query}`, {
        headers: {
          'Accept': 'application/json'
        }
      })
      .then(response => response.json())
      .then(data => {
        const projectsList = document.getElementById('projects-list');

        // Clear the current list
        projectsList.innerHTML = '';

        // Populate the list with the new search results
        data.projects.forEach(project => {
          const listItem = document.createElement('li');
          const link = document.createElement('a');
          link.href = project.url;  // Set the URL
          link.textContent = project.name;  // Set the link text
          
          // Append the link to the list item
          listItem.appendChild(link);

          // Append the list item to the projects list
          projectsList.appendChild(listItem);
        });
      })
      .catch(error => console.error('Error:', error));
    });
  }
  const searchForm = document.getElementById('bug-search-form');

  if (bugsearchInput) {
    bugsearchInput.addEventListener('input', () => {
      const query = bugsearchInput.value;

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
