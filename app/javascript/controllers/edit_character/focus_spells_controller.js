import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  data = "";
  connect() {
    this.data = document.querySelector("[data-edit-character--focus-spells-count-param]");
  }

  addFocusSpell(event) {
    let value = this.data.getAttribute("data-edit-character--focus-spells-count-param");
    value = parseInt(value);

    appendFocusSpellInForm(value);

    value += 1;
    this.data.setAttribute("data-edit-character--focus-spells-count-param", value)
  }

  removeFocusSpell(event) {
    const id = event.params.id;
    const body = document.getElementById(`focus-spells-${id}`);
    const checkBox = document.getElementById(`character_pathfinder_focus_spells_attributes_${id}__destroy`);

    body.className = "hidden";
    checkBox.checked = true;
  }
}

function appendFocusSpellInForm(value) {
  const body = [
    `<div class="flex">`,
      `<div class="flex-1">`,
        `<label class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300" for="character_pathfinder_focus_spells_attributes_${value}_name">Name</label>`,
        `<input class="rounded-none rounded-l-lg  bg-gray-50 border text-gray-900 focus:ring-blue-500 focus:border-blue-500 block flex-1 min-w-0 w-full text-sm border-gray-300 p-2.5  dark:bg-transparent dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" type="text" name="character[pathfinder_focus_spells_attributes][${value}][name]" id="character_pathfinder_focus_spells_attributes_${value}_name">`,
      `</div>`,
      `<div class="flex-1">`,
        `<div class="block mb-2 text-sm font-medium opacity-0">0</div>`,
        `<div class="rounded-none rounded-r-lg block flex-1 p-2.5 text-center font-bold cursor-pointer font-bold rounded bg-rose-500 border text-white hover:bg-red-700 hover:bg-red-500 block min-w-0 w-10 text-sm border-rose-300 dark:bg-rose-500 dark:border-rose-600 dark:text-white dark:hover:bg-rose-700" data-controller="edit-character--focus-spells" data-action="click->edit-character--focus-spells#removeFocusSpell" data-edit-character--focus-spells-id-param="${value}">`,
          `-`,
        `</div>`,
      `</div>`,
    `</div>`,
    `<div class="flex">`,
      `<div class="flex-1">`,
        `<label class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300" for="character_pathfinder_focus_spells_attributes_${value}_action">Action</label>`,
        `<select class="font-pathfinder rounded-none rounded-l-lg bg-gray-50 border text-gray-900 focus:ring-blue-500 focus:border-blue-500 block flex-1 min-w-0 w-full text-sm border-gray-300 p-2.5  dark:bg-zinc-800 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" name="character[pathfinder_focus_spells_attributes][${value}][action]" id="character_pathfinder_focus_spells_attributes_${value}_action">`,
          `<option value="1">1</option>`,
          `<option value="2">2</option>`,
          `<option value="3">3</option>`,
          `<option value="4">4</option>`,
          `<option value="5">5</option>`,
        `</select>`,
      `</div>`,
      `<div class="flex-1">`,
        `<label class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300" for="character_pathfinder_focus_spells_attributes_${value}_spell_component">Spell component</label>`,
        `<select class="rounded-none rounded-r-lg bg-gray-50 border text-gray-900 focus:ring-blue-500 focus:border-blue-500 block flex-1 min-w-0 w-full text-sm border-gray-300 p-2.5  dark:bg-zinc-800 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" name="character[pathfinder_focus_spells_attributes][${value}][spell_component]" id="character_pathfinder_focus_spells_attributes_${value}_spell_component">`,
          `<option value="Material">Material</option>`,
          `<option value="Somatic">Somatic</option>`,
          `<option value="Verbal">Verbal</option>`,
        `</select>`,
      `</div>`,
    `</div>`,
    `<div>`,
      `<label class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300" for="character_pathfinder_focus_spells_attributes_${value}_notes">Notes</label>`,
      `<textarea class="rounded bg-gray-50 border text-gray-900 focus:ring-blue-500 focus:border-blue-500 block flex-1 min-w-0 w-full text-sm border-gray-300 p-2.5  dark:bg-transparent dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" name="character[pathfinder_focus_spells_attributes][${value}][notes]" id="character_pathfinder_focus_spells_attributes_${value}_notes"></textarea>`,
    `</div>`,
    `<input name="character[pathfinder_focus_spells_attributes][${value}][_destroy]" type="hidden" value="0" autocomplete="off"><input class="hidden" type="checkbox" value="1" name="character[pathfinder_focus_spells_attributes][${value}][_destroy]" id="character_pathfinder_focus_spells_attributes_${value}__destroy">`
  ].join('');
  
  const div = document.createElement("div");
  const bodyFocusSpell = document.getElementById("body-focus-spells");

  div.innerHTML = body;
  div.id = `focus-spells-${value}`;
  div.className = "space-y-3 pb-3 border-b border-gray-300 dark:border-gray-500"

  bodyFocusSpell.appendChild(div);
}
