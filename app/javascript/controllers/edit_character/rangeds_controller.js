import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  data = "";
  connect() {
    this.data = document.querySelector("[data-edit-character--rangeds-count-param]");
  }

  addRanged(event) {
    let value = this.data.getAttribute("data-edit-character--rangeds-count-param");
    value = parseInt(value);

    appendRangedInForm(value);

    value += 1;
    this.data.setAttribute("data-edit-character--rangeds-count-param", value)
  }

  removeRanged(event) {
    const id = event.params.id;
    const body = document.getElementById(`rangeds-${id}`);
    const checkBox = document.getElementById(`character_pathfinder_rangeds_attributes_${id}__destroy`);

    body.className = "hidden";
    checkBox.checked = true;
  }
}

function appendRangedInForm(value) {
  const body = [
    `<div class="flex">`,
      `<div class="flex-1">`,
        `<label class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300" for="character_pathfinder_rangeds_attributes_${value}_name">Name</label>`,
        `<input class="rounded-none rounded-l-lg  bg-gray-50 border text-gray-900 focus:ring-blue-500 focus:border-blue-500 block flex-1 min-w-0 w-full text-sm border-gray-300 p-2.5  dark:bg-transparent dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" type="text" name="character[pathfinder_rangeds_attributes][${value}][name]" id="character_pathfinder_rangeds_attributes_${value}_name">`,
      `</div>`,
      `<div class="flex-1">`,
        `<label class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300" for="character_pathfinder_rangeds_attributes_${value}_types">Types</label>`,
        `<select class="rounded-none bg-gray-50 border text-gray-900 focus:ring-blue-500 focus:border-blue-500 block flex-1 min-w-0 w-full text-sm border-gray-300 p-2.5  dark:bg-zinc-800 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" name="character[pathfinder_rangeds_attributes][${value}][types]" id="character_pathfinder_rangeds_attributes_${value}_types">`,
          `<option value="Bludgeoning">Bludgeoning</option>`,
          `<option value="Piercing">Piercing</option>`,
          `<option value="Slashing">Slashing</option>`,
        `</select>`,
      `</div>`,
      `<div class="flex-1">`,
        `<div class="block mb-2 text-sm font-medium opacity-0">0</div>`,
        `<div class="rounded-none rounded-r-lg block flex-1 p-2.5 text-center font-bold cursor-pointer font-bold rounded bg-rose-500 border text-white hover:bg-red-700 hover:bg-red-500 block min-w-0 w-10 text-sm border-rose-300 dark:bg-rose-500 dark:border-rose-600 dark:text-white dark:hover:bg-rose-700" data-controller="edit-character--rangeds" data-action="click->edit-character--rangeds#removeRanged" data-edit-character--rangeds-id-param="${value}">`,
          `-`,
        `</div>`,
      `</div>`,
    `</div>`,
    `<div class="flex">`,
      `<div class="flex-1">`,
        `<label class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300" for="character_pathfinder_rangeds_attributes_${value}_qty">Qty</label>`,
        `<input class="rounded-none rounded-l-lg  bg-gray-50 border text-gray-900 focus:ring-blue-500 focus:border-blue-500 block flex-1 min-w-0 w-full text-sm border-gray-300 p-2.5  dark:bg-transparent dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" type="text" name="character[pathfinder_rangeds_attributes][${value}][qty]" id="character_pathfinder_rangeds_attributes_${value}_qty">`,
      `</div>`,
      `<div class="flex-1">`,
        `<label class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300" for="character_pathfinder_rangeds_attributes_${value}_die">Die</label>`,
        `<select class="rounded-none bg-gray-50 border text-gray-900 focus:ring-blue-500 focus:border-blue-500 block flex-1 min-w-0 w-full text-sm border-gray-300 p-2.5  dark:bg-zinc-800 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" name="character[pathfinder_rangeds_attributes][${value}][die]" id="character_pathfinder_rangeds_attributes_${value}_die">`,
          `<option value="d4">d4</option>`,
          `<option value="d6">d6</option>`,
          `<option value="d8">d8</option>`,
          `<option value="d10">d10</option>`,
          `<option value="d12">d12</option>`,
          `<option value="d20">d20</option>`,
          `<option value="d100">d100</option>`,
        `</select>`,
      `</div>`,
      `<div class="flex-1">`,
        `<label class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300" for="character_pathfinder_rangeds_attributes_${value}_weapon_specialization">w. spec.</label>`,
        `<input class="rounded-none bg-gray-50 border text-gray-900 focus:ring-blue-500 focus:border-blue-500 block flex-1 min-w-0 w-full text-sm border-gray-300 p-2.5  dark:bg-transparent dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" type="number" name="character[pathfinder_rangeds_attributes][${value}][weapon_specialization]" id="character_pathfinder_rangeds_attributes_${value}_weapon_specialization">`,
      `</div>`,
      `<div class="flex-1">`,
        `<label class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300" for="character_pathfinder_rangeds_attributes_${value}_proficiency">Proficiency</label>`,
        `<select class="rounded-none bg-gray-50 border text-gray-900 focus:ring-blue-500 focus:border-blue-500 block flex-1 min-w-0 w-full text-sm border-gray-300 p-2.5  dark:bg-zinc-800 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" name="character[pathfinder_rangeds_attributes][${value}][proficiency]" id="character_pathfinder_rangeds_attributes_${value}_proficiency">`,
          `<option value="0">Untrained</option>`,
          `<option value="2">Trained</option>`,
          `<option value="4">Expert</option>`,
          `<option value="6">Master</option>`,
          `<option value="8">Legendary</option>`,
        `</select>`,
      `</div>`,
      `<div class="flex-1">`,
        `<label class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300" for="character_pathfinder_rangeds_attributes_${value}_item">Item</label>`,
        `<input class="rounded-none rounded-r-lg bg-gray-50 border text-gray-900 focus:ring-blue-500 focus:border-blue-500 block flex-1 min-w-0 w-full text-sm border-gray-300 p-2.5  dark:bg-transparent dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" type="text" name="character[pathfinder_rangeds_attributes][${value}][item]" id="character_pathfinder_rangeds_attributes_${value}_item">`,
      `</div>`,
    `</div>`,
    `<div class="flex">`,
      `<div class="flex-1">`,
        `<label class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300" for="character_pathfinder_rangeds_attributes_${value}_multiple_attack_penalty_2">Multiple attack penalty 2</label>`,
        `<input class="rounded-none rounded-l-lg  bg-gray-50 border text-gray-900 focus:ring-blue-500 focus:border-blue-500 block flex-1 min-w-0 w-full text-sm border-gray-300 p-2.5  dark:bg-transparent dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" type="text" name="character[pathfinder_rangeds_attributes][${value}][multiple_attack_penalty_2]" id="character_pathfinder_rangeds_attributes_${value}_multiple_attack_penalty_2">`,
      `</div>`,
      `<div class="flex-1">`,
        `<label class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300" for="character_pathfinder_rangeds_attributes_${value}_multiple_attack_penalty_3">Multiple attack penalty 3</label>`,
        `<input class="rounded-none rounded-r-lg bg-gray-50 border text-gray-900 focus:ring-blue-500 focus:border-blue-500 block flex-1 min-w-0 w-full text-sm border-gray-300 p-2.5  dark:bg-transparent dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" type="text" name="character[pathfinder_rangeds_attributes][${value}][multiple_attack_penalty_3]" id="character_pathfinder_rangeds_attributes_${value}_multiple_attack_penalty_3">`,
      `</div>`,
    `</div>`,
    `<div class="w-32">`,
      `<label class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300" for="character_pathfinder_rangeds_attributes_${value}_special">Special</label>`,
      `<input class="rounded bg-gray-50 border text-gray-900 focus:ring-blue-500 focus:border-blue-500 block flex-1 min-w-0 w-full text-sm border-gray-300 p-2.5  dark:bg-transparent dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" type="text" name="character[pathfinder_rangeds_attributes][${value}][special]" id="character_pathfinder_rangeds_attributes_${value}_special">`,
    `</div>`,
    `<div>`,
      `<label class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300" for="character_pathfinder_rangeds_attributes_${value}_other">Other</label>`,
      `<input class="rounded bg-gray-50 border text-gray-900 focus:ring-blue-500 focus:border-blue-500 block flex-1 min-w-0 w-full text-sm border-gray-300 p-2.5  dark:bg-transparent dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" type="text" name="character[pathfinder_rangeds_attributes][${value}][other]" id="character_pathfinder_rangeds_attributes_${value}_other">`,
    `</div>`,
    `<div>`,
      `<label class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300" for="character_pathfinder_rangeds_attributes_${value}_traits">Traits</label>`,
      `<input class="rounded bg-gray-50 border text-gray-900 focus:ring-blue-500 focus:border-blue-500 block flex-1 min-w-0 w-full text-sm border-gray-300 p-2.5  dark:bg-transparent dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" type="text" name="character[pathfinder_rangeds_attributes][${value}][traits]" id="character_pathfinder_rangeds_attributes_${value}_traits">`,
    `</div>`,
    `<div>`,
      `<label class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300" for="character_pathfinder_rangeds_attributes_${value}_notes">Notes</label>`,
      `<textarea class="rounded bg-gray-50 border text-gray-900 focus:ring-blue-500 focus:border-blue-500 block flex-1 min-w-0 w-full text-sm border-gray-300 p-2.5  dark:bg-transparent dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" name="character[pathfinder_rangeds_attributes][${value}][notes]" id="character_pathfinder_rangeds_attributes_${value}_notes"></textarea>`,
    `</div>`,
    `<input name="character[pathfinder_rangeds_attributes][${value}][_destroy]" type="hidden" value="0" autocomplete="off"><input class="hidden" type="checkbox" value="1" name="character[pathfinder_rangeds_attributes][${value}][_destroy]" id="character_pathfinder_rangeds_attributes_${value}__destroy">`
  ].join('');
  
  const div = document.createElement("div");
  const bodyRanged = document.getElementById("body-rangeds");

  div.innerHTML = body;
  div.id = `rangeds-${value}`;
  div.className = `space-y-3`;

  bodyRanged.appendChild(div);
}
