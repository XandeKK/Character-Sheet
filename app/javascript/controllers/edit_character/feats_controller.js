import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  data = "";
  connect() {
    this.data = document.querySelector("[data-edit-character--feats-count-param]");
  }

  addFeat(event) {
    let value = this.data.getAttribute("data-edit-character--feats-count-param");
    value = parseInt(value);

    appendFeatInForm(value);

    value += 1;
    this.data.setAttribute("data-edit-character--feats-count-param", value)
  }

  removeFeat(event) {
    const id = event.params.id;
    const body = document.getElementById(`feats-${id}`);
    const checkBox = document.getElementById(`character_pathfinder_feats_attributes_${id}__destroy`);

    body.className = "hidden";
    checkBox.checked = true;
  }
}

function appendFeatInForm(value) {
  const body = [
    `<div class="flex">`,
      `<div class="flex-1">`,
        `<label class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300" for="character_pathfinder_feats_attributes_${value}_name">Name</label>`,
        `<input class="rounded-none rounded-l-lg  bg-gray-50 border text-gray-900 focus:ring-blue-500 focus:border-blue-500 block flex-1 min-w-0 w-full text-sm border-gray-300 p-2.5  dark:bg-transparent dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" type="text" name="character[pathfinder_feats_attributes][${value}][name]" id="character_pathfinder_feats_attributes_${value}_name">`,
      `</div>`,
      `<div class="flex-1">`,
        `<label class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300" for="character_pathfinder_feats_attributes_${value}_types">Types</label>`,
        `<select class="rounded-none bg-gray-50 border text-gray-900 focus:ring-blue-500 focus:border-blue-500 block flex-1 min-w-0 w-full text-sm border-gray-300 p-2.5  dark:bg-zinc-800 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" name="character[pathfinder_feats_attributes][${value}][types]" id="character_pathfinder_feats_attributes_${value}_types">`,
          `<option value="Ancestry">Ancestry</option>`,
          `<option value="Class">Class</option>`,
          `<option value="Skill">Skill</option>`,
          `<option value="General">General</option>`,
          `<option value="Bonus">Bonus</option>`,
        `</select>`,
      `</div>`,
      `<div class="flex-1">`,
        `<div class="block mb-2 text-sm font-medium opacity-0">0</div>`,
        `<div class="rounded-none rounded-r-lg block flex-1 p-2.5 text-center font-bold cursor-pointer font-bold rounded bg-rose-500 border text-white hover:bg-red-700 hover:bg-red-500 block min-w-0 w-10 text-sm border-rose-300 dark:bg-rose-500 dark:border-rose-600 dark:text-white dark:hover:bg-rose-700"  data-controller="edit-character--feats" data-action="click->edit-character--feats#removeFeat" data-edit-character--feats-id-param="${value}">`,
          `-`,
        `</div>`,
      `</div>`,
    `</div>`,
    `<div>`,
      `<label class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300" for="character_pathfinder_feats_attributes_${value}_notes">Notes</label>`,
      `<textarea class="rounded bg-gray-50 border text-gray-900 focus:ring-blue-500 focus:border-blue-500 block flex-1 min-w-0 w-full text-sm border-gray-300 p-2.5  dark:bg-transparent dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" name="character[pathfinder_feats_attributes][${value}][notes]" id="character_pathfinder_feats_attributes_${value}_notes"></textarea>`,
    `</div>`,
    `<input class="hidden" type="checkbox" value="1" name="character[pathfinder_feats_attributes][${value}][_destroy]" id="character_pathfinder_feats_attributes_${value}__destroy">`
  ].join('');
  
  const div = document.createElement("div");
  const bodyFeats = document.getElementById("body-feats");

  div.innerHTML = body;
  div.id = `feats-${value}`;

  bodyFeats.appendChild(div);
}

