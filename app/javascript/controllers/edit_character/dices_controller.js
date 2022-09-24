import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  data = "";
  connect() {
    this.data = document.querySelector("[data-edit-character--dices-count-param]");
  }

  addDice(event) {
    let value = this.data.getAttribute("data-edit-character--dices-count-param");
    value = parseInt(value);

    appendDiceInForm(value);

    value += 1;
    this.data.setAttribute("data-edit-character--dices-count-param", value)
  }

  removeDice(event) {
    const id = event.params.id;
    const body = document.getElementById(`dices-${id}`);
    const checkBox = document.getElementById(`character_dices_attributes_${id}__destroy`);

    body.className = "hidden";
    checkBox.checked = true;
  }
}

function appendDiceInForm(value) {
  const body = [
    `<div class="flex">`,
      `<div class="flex-1">`,
        `<label class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300" for="character_dices_attributes_${value}_name">Name</label>`,
        `<input class="rounded-none rounded-l-lg  bg-gray-50 border text-gray-900 focus:ring-blue-500 focus:border-blue-500 block flex-1 min-w-0 w-full text-sm border-gray-300 p-2.5  dark:bg-transparent dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" type="text" name="character[dices_attributes][${value}][name]" id="character_dices_attributes_${value}_name">`,
      `</div>`,
      `<div class="flex-1">`,
        `<div class="block mb-2 text-sm font-medium opacity-0">0</div>`,
        `<div class="rounded-none rounded-r-lg block flex-1 p-2.5 text-center font-bold cursor-pointer font-bold rounded bg-rose-500 border text-white hover:bg-red-700 hover:bg-red-500 block min-w-0 w-10 text-sm border-rose-300 dark:bg-rose-500 dark:border-rose-600 dark:text-white dark:hover:bg-rose-700" data-controller="edit-character--dices" data-action="click->edit-character--dices#removeDice" data-edit-character--dices-id-param="0">`,
          `-`,
        `</div>`,
      `</div>`,
    `</div>`,
    `<div>`,
      `<label class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300" for="character_dices_attributes_${value}_notation">Notation</label>`,
      `<input class="rounded bg-gray-50 border text-gray-900 focus:ring-blue-500 focus:border-blue-500 block flex-1 min-w-0 w-full text-sm border-gray-300 p-2.5  dark:bg-transparent dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" type="text" name="character[dices_attributes][${value}][notation]" id="character_dices_attributes_${value}_notation">`,
    `</div>`,
    `<div>`,
      `<label class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300" for="character_dices_attributes_${value}_notes">Notes</label>`,
      `<textarea class="rounded bg-gray-50 border text-gray-900 focus:ring-blue-500 focus:border-blue-500 block flex-1 min-w-0 w-full text-sm border-gray-300 p-2.5  dark:bg-transparent dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" name="character[dices_attributes][${value}][notes]" id="character_dices_attributes_${value}_notes"></textarea>`,
    `</div>`,
    `<input name="character[dices_attributes][${value}][_destroy]" type="hidden" value="0" autocomplete="off"><input class="hidden" type="checkbox" value="1" name="character[dices_attributes][${value}][_destroy]" id="character_dices_attributes_${value}__destroy">`,
  ].join('');
  
  const div = document.createElement("div");
  const bodyDices = document.getElementById("body-dices");

  div.innerHTML = body;
  div.id = `dices-${value}`;

  bodyDices.appendChild(div);
}
