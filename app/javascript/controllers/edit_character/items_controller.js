import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  data = "";
  connect() {
    this.data = document.querySelector("[data-edit-character--items-count-param]");
  }

  addItem(event) {
    let value = this.data.getAttribute("data-edit-character--items-count-param");
    value = parseInt(value);

    appendItemInForm(value);

    value += 1;
    this.data.setAttribute("data-edit-character--items-count-param", value)
  }

  removeItem(event) {
    const id = event.params.id;
    const body = document.getElementById(`items-${id}`);
    const checkBox = document.getElementById(`character_pathfinder_items_attributes_${id}__destroy`);

    body.className = "hidden";
    checkBox.checked = true;
  }
}

function appendItemInForm(value) {
  const body = [
    `<div class="flex">`,
      `<div>`,
        `<label class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300" for="character_pathfinder_items_attributes_${value}_name">Name</label>`,
        `<input class="rounded-none rounded-l-lg  bg-gray-50 border text-gray-900 focus:ring-blue-500 focus:border-blue-500 block flex-1 min-w-0 w-full text-sm border-gray-300 p-2.5  dark:bg-transparent dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" type="text" name="character[pathfinder_items_attributes][${value}][name]" id="character_pathfinder_items_attributes_${value}_name">`,
      `</div>`,
      `<div>`,
        `<label class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300" for="character_pathfinder_items_attributes_${value}_quatity">Quatity</label>`,
        `<input class="rounded-none bg-gray-50 border text-gray-900 focus:ring-blue-500 focus:border-blue-500 block flex-1 min-w-0 w-full text-sm border-gray-300 p-2.5  dark:bg-transparent dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" type="number" name="character[pathfinder_items_attributes][${value}][quatity]" id="character_pathfinder_items_attributes_${value}_quatity">`,
      `</div>`,
      `<div>`,
        `<label class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300" for="character_pathfinder_items_attributes_${value}_volume">Volume</label>`,
        `<input class="rounded-none bg-gray-50 border text-gray-900 focus:ring-blue-500 focus:border-blue-500 block flex-1 min-w-0 w-full text-sm border-gray-300 p-2.5  dark:bg-transparent dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" type="number" name="character[pathfinder_items_attributes][${value}][volume]" id="character_pathfinder_items_attributes_${value}_volume">`,
      `</div>`,
      `<div>`,
        `<div class="block mb-2 text-sm font-medium opacity-0">0</div>`,
        `<div class="rounded-none rounded-r-lg block flex-1 p-2.5 text-center font-bold cursor-pointer font-bold rounded bg-rose-500 border text-white hover:bg-red-700 hover:bg-red-500 block min-w-0 w-10 text-sm border-rose-300 dark:bg-rose-500 dark:border-rose-600 dark:text-white dark:hover:bg-rose-700"  data-controller="edit-character--items" data-action="click->edit-character--items#removeItem" data-edit-character--items-id-param="${value}">`,
          `-`,
        `</div>`,
      `</div>`,
    `</div>`,
    `<div>`,
      `<label class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300" for="character_pathfinder_items_attributes_${value}_notes">Notes</label>`,
      `<textarea class="rounded bg-gray-50 border text-gray-900 focus:ring-blue-500 focus:border-blue-500 block flex-1 min-w-0 w-full text-sm border-gray-300 p-2.5  dark:bg-transparent dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" name="character[pathfinder_items_attributes][${value}][notes]" id="character_pathfinder_items_attributes_${value}_notes"></textarea>`,
    `</div>`,
    `<input class="hidden" type="checkbox" value="1" name="character[pathfinder_items_attributes][${value}][_destroy]" id="character_pathfinder_items_attributes_${value}__destroy">`
  ].join('');
  
  const div = document.createElement("div");
  const bodyItem = document.getElementById("body-items");

  div.innerHTML = body;
  div.id = `items-${value}`;

  bodyItem.appendChild(div);
}
