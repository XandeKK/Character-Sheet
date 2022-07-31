class BaseUI {
	createDiv(id, parent) {
		let div = document.createElement("div");
		let div_parent = document.getElementById(parent);

		if (div_parent === undefined) { div_parent = document.querySelector("body"); }

		div.id = id;

		div_parent.appendChild(div);
	}

	createTitle(title, parent) {
		let h3 = document.createElement("h3");
		let div_parent = document.getElementById(parent);

		if (div_parent === undefined) { div_parent = document.querySelector("body"); }

		h3.innerText = title;

		div_parent.appendChild(h3);
	}

	createLabel(name) {
		let label = document.createElement("label");
		label.innerText = name;
		return label;
	}

	createInput(name, id, parent, type) {
		let div = document.createElement("div");
		let input = document.createElement("input");
		let div_parent = document.getElementById(parent);
		let label = this.createLabel(name)

		input.id = parent + "_" + id;
		input.className = "character";
		input.type = type;

		input.value = characterUI.getValue(input.id); // Get value and put into input

		div.appendChild(label);
		div.appendChild(input);

		div_parent.appendChild(div);
	}

	createTextArea(name, id, parent) {
		let div = document.createElement("div");
		let textarea = document.createElement("textarea");
		let div_parent = document.getElementById(parent);
		let label = this.createLabel(name)

		textarea.id = parent + "_" + id;
		textarea.className = "character";

		textarea.value = characterUI.getValue(textarea.id); // Get value and put into textarea

		div.appendChild(label);
		div.appendChild(textarea);

		div_parent.appendChild(div);
	}

	createSelect(name, id, parent, options) {
		let div = document.createElement("div");
		let select = document.createElement("select");
		let div_parent = document.getElementById(parent);
		let label = this.createLabel(name)

		select.id = parent + "_" + id;
		select.className = "character";

		for (var i = 0; i < options.length; i++) {
			let option = document.createElement("option");
			option.innerText = options[i].name
			option.value = options[i].value
			select.appendChild(option)
		}

		select.value = characterUI.getValue(select.id); // Get value and put into input

		div.appendChild(label);
		div.appendChild(select);
		
		div_parent.appendChild(div);
	}

	addCreateButton(name, id) {
		let button = document.createElement("div")
		let div_parent = document.getElementById(id)

		button.innerText = "Add " + name;
		button.setAttribute("action", id);
		button.addEventListener("click", this.eventCreate);

		div_parent.appendChild(button);
	}

	addDeleteButton(id) {
		let button = document.createElement("div")
		let div_parent = document.getElementById(id)

		button.innerText = "-";
		button.className = "delete_button";
		button.setAttribute("action", id);
		button.addEventListener("click", this.eventDelete);

		div_parent.appendChild(button);			
	}

	eventCreate(event) {
		let action = event.target.getAttribute("action");

		let length = main_json['character'][action].length;

		let id = "character_" + action + "_" + length;
		base.createDiv(id, action);

		switch (action) {
			case "meleeStrikes":
				characterUI.createWeapon(true, "meleeStrikes", id); // How to get parent and create div
				break;
			case "rangedStrikes":
				characterUI.createWeapon(true, "rangedStrikes", id); // How to get parent and create div
				break;
			case "languages":
				characterUI.createLanguages(true, id); // How to get parent and create div
				break;
			case "bonusFeats":
				characterUI.createBonusFeats(true, id); // How to get parent and create div
				break;
			case "inventory":
				characterUI.createInventory(true, id); // How to get parent and create div
				break;
			default:
				console.log("Error")
		}
	}

	eventDelete(event) {
		let action = event.target.getAttribute("action");
		let div = document.getElementById(action)

		let path = action.split("_"); // 0 = character, 1 = parent, 2 = index
		let array = main_json[path[0]][path[1]];
		array.splice(path[2], 1);

		div.remove();
		base.sortArray(path[1]);
	}

	sortArray(parent) {
		let div_parent = document.getElementById(parent);
		let array_div = div_parent.childNodes
		let cont = 0;
		array_div = Array.from(array_div)

		for (var i = 0; i < array_div.length; i++) {
			if (document.getElementById(array_div[i].id) === null) {continue;}
			
			this.renamingIdAndAction(array_div[i], cont);
			this.renamingInput(array_div[i], cont);

			cont++
		}
	}

	renamingIdAndAction(div, number) {
		let id = div.id;
		let split_id = id.split("_");

		split_id[2] = number;
		id = split_id.join("_");
		div.id = id;

		let deleteButton = div.getElementsByClassName("delete_button")[0];
		deleteButton.setAttribute("action", id);
	}

	renamingInput(div, number) {
		let array_input = div.getElementsByClassName("character");
		for (var i = 0; i < array_input.length; i++) {
		
			let id = array_input[i].id;
			let split_id = id.split("_");

			split_id[2] = number;
			id = split_id.join("_");
			array_input[i].id = id;
		}
	}
};