// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require pagy
//= require turbolinks
//= require_tree .

window.addEventListener("turbolinks:load", Pagy.init);

function sortTagsByCount() {
  var tags = document.querySelectorAll("[data-tag-count]");
  var tagsArray = Array.from(tags);
  let sortedTags = tagsArray.sort(sortedByCount);
  sortedTags.forEach(e => document.querySelector("#tags").appendChild(e));
  document.querySelectorAll("[data-tag-count]").forEach(e => e.insertAdjacentHTML('beforebegin', '        '));
  toggleSortOptions();
}

function sortedByCount(b,a) {
  if(parseInt(a.dataset.tagCount) < parseInt(b.dataset.tagCount)) return -1;
  if(parseInt(a.dataset.tagCount) > parseInt(b.dataset.tagCount)) return 1;
}

function sortTagsByName() {
  var tags = document.querySelectorAll("[data-tag-name]");
  var tagsArray = Array.from(tags);
  let sortedTags = tagsArray.sort(sortedByName);
  sortedTags.forEach(e => document.querySelector("#tags").appendChild(e));
  document.querySelectorAll("[data-tag-count]").forEach(e => e.insertAdjacentHTML('beforebegin', '        '));
  toggleSortOptions();
}

function sortedByName(a,b) {
  if(a.dataset.tagName < b.dataset.tagName) return -1;
  if(a.dataset.tagName > b.dataset.tagName) return 1;
}

function toggleSortOptions() {
  var countElement = document.getElementById("sort_by_count");
  countElement.classList.toggle("font-weight-bold");
  var nameElement = document.getElementById("sort_by_name");
  nameElement.classList.toggle("font-weight-bold");
}