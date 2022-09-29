import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  data = "";
  connect() {
    this.data = document.querySelector("[data-edit-character--skills-count-param]");
  }

  addSkill(event) {
    let value = this.data.getAttribute("data-edit-character--skills-count-param");
    value = parseInt(value);

    appendSkillInForm(value);

    value += 1;
    this.data.setAttribute("data-edit-character--skills-count-param", value)
  }

  removeSkill(event) {
    const id = event.params.id;
    const body = document.getElementById(`skills-${id}`);
    const checkBox = document.getElementById(`character_pathfinder_skills_attributes_${id}__destroy`);

    body.className = "hidden";
    checkBox.checked = true;
  }
}

function appendSkillInForm(value) {
  const body = [
    `<div class="flex">`,
      `<div class="flex-1">`,
        `<label class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300" for="character_pathfinder_skills_attributes_${value}_name">Name</label>`,
        `<input class="rounded-none rounded-l-lg  bg-gray-50 border text-gray-900 focus:ring-blue-500 focus:border-blue-500 block flex-1 min-w-0 w-full text-sm border-gray-300 p-2.5  dark:bg-transparent dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" type="text" name="character[pathfinder_skills_attributes][${value}][name]" id="character_pathfinder_skills_attributes_${value}_name">`,
      `</div>`,
      `<div class="flex-1">`,
        `<div class="block mb-2 text-sm font-medium opacity-0">0</div>`,
        `<div class="rounded-none rounded-r-lg block flex-1 p-2.5 text-center font-bold cursor-pointer font-bold rounded bg-rose-500 border text-white hover:bg-red-700 hover:bg-red-500 block min-w-0 w-10 text-sm border-rose-300 dark:bg-rose-500 dark:border-rose-600 dark:text-white dark:hover:bg-rose-700" data-controller="edit-character--skills" data-action="click->edit-character--skills#removeSkill" data-edit-character--skills-id-param="${value}">`,
          `-`,
        `</div>`,
      `</div>`,
    `</div>`,
    `<div class="flex">`,
      `<div class="flex-1">`,
        `<label class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300" for="character_pathfinder_skills_attributes_${value}_key_ability">Key ability</label>`,
        `<select class="rounded-none rounded-l-lg  bg-gray-50 border text-gray-900 focus:ring-blue-500 focus:border-blue-500 block flex-1 min-w-0 w-full text-sm border-gray-300 p-2.5  dark:bg-zinc-800 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" name="character[pathfinder_skills_attributes][${value}][key_ability]" id="character_pathfinder_skills_attributes_${value}_key_ability">`,
          `<option value="str">Strength</option>`,
          `<option value="dex">Dexterity</option>`,
          `<option value="con">Constitution</option>`,
          `<option value="int">Intelligence</option>`,
          `<option value="wis">Wisdom</option>`,
          `<option value="cha">Charisma</option>`,
        `</select>`,
      `</div>`,
      `<div class="flex-1">`,
        `<label class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300" for="character_pathfinder_skills_attributes_${value}_proficiency">Proficiency</label>`,
        `<select class="rounded-none bg-gray-50 border text-gray-900 focus:ring-blue-500 focus:border-blue-500 block flex-1 min-w-0 w-full text-sm border-gray-300 p-2.5  dark:bg-zinc-800 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" name="character[pathfinder_skills_attributes][${value}][proficiency]" id="character_pathfinder_skills_attributes_${value}_proficiency">`,
          `<option value="0">Untrained</option>`,
          `<option value="2">Trained</option>`,
          `<option value="4">Expert</option>`,
          `<option value="6">Master</option>`,
          `<option value="8">Legendary</option>`,
        `</select>`,
      `</div>`,
      `<div class="flex-1">`,
        `<label class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300" for="character_pathfinder_skills_attributes_${value}_item">Item</label>`,
        `<input class="rounded-none bg-gray-50 border text-gray-900 focus:ring-blue-500 focus:border-blue-500 block flex-1 min-w-0 w-full text-sm border-gray-300 p-2.5  dark:bg-transparent dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" type="number" name="character[pathfinder_skills_attributes][${value}][item]" id="character_pathfinder_skills_attributes_${value}_item" value="0">`,
      `</div>`,
      `<div class="flex-1">`,
        `<label class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300" for="character_pathfinder_skills_attributes_${value}_armor">Armor</label>`,
        `<input class="rounded-none rounded-r-lg bg-gray-50 border text-gray-900 focus:ring-blue-500 focus:border-blue-500 block flex-1 min-w-0 w-full text-sm border-gray-300 p-2.5  dark:bg-transparent dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" type="number" name="character[pathfinder_skills_attributes][${value}][armor]" id="character_pathfinder_skills_attributes_${value}_armor" value="0">`,
      `</div>`,
    `</div>`,
    `<div>`,
      `<label class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300" for="character_pathfinder_skills_attributes_${value}_note">Note</label>`,
      `<textarea class="rounded bg-gray-50 border text-gray-900 focus:ring-blue-500 focus:border-blue-500 block flex-1 min-w-0 w-full text-sm border-gray-300 p-2.5  dark:bg-transparent dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" name="character[pathfinder_skills_attributes][${value}][note]" id="character_pathfinder_skills_attributes_${value}_note"></textarea>`,
    `</div>`,
    `<input name="character[pathfinder_skills_attributes][${value}][_destroy]" type="hidden" value="0" autocomplete="off"><input class="hidden" type="checkbox" value="1" name="character[pathfinder_skills_attributes][${value}][_destroy]" id="character_pathfinder_skills_attributes_${value}__destroy">`,
  ].join('');
  
  const div = document.createElement("div");
  const bodySkills = document.getElementById("body-skills");

  div.innerHTML = body;
  div.id = `skills-${value}`;
  div.className = "space-y-3 pb-3 border-b border-gray-300 dark:border-gray-500"

  bodySkills.appendChild(div);
}

