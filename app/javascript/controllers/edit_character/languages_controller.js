import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  data = "";
  connect() {
    this.data = document.querySelector("[data-edit-character--languages-count-param]");
  }

  addLanguage(event) {
    let value = this.data.getAttribute("data-edit-character--languages-count-param");
    value = parseInt(value);

    appendLanguageInForm(value);

    value += 1;
    this.data.setAttribute("data-edit-character--languages-count-param", value)
  }

  removeLanguage(event) {
    const id = event.params.id;
    const body = document.getElementById(`languages-${id}`);
    const checkBox = document.getElementById(`character_pathfinder_languages_attributes_${id}__destroy`);

    body.className = "hidden";
    checkBox.checked = true;
  }
}

function appendLanguageInForm(value) {
  const body = [
    `<div class="flex">`,
      `<div>`,
        `<label class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300" for="character_pathfinder_languages_attributes_${value}_name">Name</label>`,
        `<input class="rounded-none rounded-l-lg  bg-gray-50 border text-gray-900 focus:ring-blue-500 focus:border-blue-500 block flex-1 min-w-0 w-full text-sm border-gray-300 p-2.5  dark:bg-transparent dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" type="text" name="character[pathfinder_languages_attributes][${value}][name]" id="character_pathfinder_languages_attributes_${value}_name">`,
      `</div>`,
      `<div>`,
        `<div class="block mb-2 text-sm font-medium opacity-0">0</div>`,
        `<div class="rounded-none rounded-r-lg block flex-1 p-2.5 text-center font-bold cursor-pointer font-bold rounded bg-rose-500 border text-white hover:bg-red-700 hover:bg-red-500 block min-w-0 w-10 text-sm border-rose-300 dark:bg-rose-500 dark:border-rose-600 dark:text-white dark:hover:bg-rose-700"  data-controller="edit-character--languages" data-action="click->edit-character--languages#removeLanguage" data-edit-character--languages-id-param="${value}">`,
          `-`,
        `</div>`,
      `</div>`,
    `</div>`,
    `<div>`,
      `<label class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300" for="character_pathfinder_languages_attributes_${value}_notes">Notes</label>`,
      `<textarea class="rounded bg-gray-50 border text-gray-900 focus:ring-blue-500 focus:border-blue-500 block flex-1 min-w-0 w-full text-sm border-gray-300 p-2.5  dark:bg-transparent dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" name="character[pathfinder_languages_attributes][${value}][notes]" id="character_pathfinder_languages_attributes_${value}_notes"></textarea>`,
    `</div>`,
    `<input class="hidden" type="checkbox" value="1" name="character[pathfinder_languages_attributes][${value}][_destroy]" id="character_pathfinder_languages_attributes_${value}__destroy">`
  ].join('');
  
  const div = document.createElement("div");
  const bodyLanguage = document.getElementById("body-languages");

  div.innerHTML = body;
  div.id = `languages-${value}`;

  bodyLanguage.appendChild(div);
}