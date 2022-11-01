import { Controller } from "@hotwired/stimulus"
import bodies from "./bodies"

export default class extends Controller {
  add(event) {
    let value = parseInt(event.params.count);

    this.appendForm(value, event.params.name);

    value += 1;
    event.target.setAttribute(`data-edit-character--item-count-param`, value)
  }

  remove(event) {
    const body = document.getElementById(`${event.params.name}-${event.params.id}`);
    const checkBox = document.getElementById(`character_pathfinder_${event.params.name}_attributes_${event.params.id}__destroy`);

    body.className = "hidden";
    checkBox.checked = true;
  }

  appendForm(value, name) {
    let body = bodies[name];
    body = body.replaceAll("--value--", value);
    
    const div = document.createElement("div");
    const bodyItem = document.getElementById(`body-${name}`);

    div.innerHTML = body;
    div.id = `${name}-${value}`;
    div.className = "space-y-3 pb-3 border-b border-gray-300 dark:border-gray-500"

    bodyItem.appendChild(div);
  }
}
