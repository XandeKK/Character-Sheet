function saveJson(event) {
	let inputs = document.querySelectorAll(".character");
	let character_statistic = document.getElementById("character_statistic");

	for (var i = 0; i < inputs.length; i++) {
		let path = inputs[i].id.split("_"); // 0 = character or parent, 1 = parent or child, 2 = index or child, 3 = child

		if (Array.isArray(main_json["character"][path[1]])) {
			main_json["character"][path[1]][path[2]][path[3]] = inputs[i].value;
		} else {
			main_json["character"][path[0]][path[1]] = inputs[i].value;
		}
	}

	character_statistic.value = JSON.stringify(main_json);
	setInputName();
	setImage();
}

// Save json
const submit = document.getElementById("submit");
submit.addEventListener("click", saveJson);

function setInputName() {
	let character_name = document.getElementById("character_name");
	character_name.value = main_json["character"]["details"]["name"];
}

function setImage() {
	if (isDirtyImage) {
		vanilla.result({type: 'base64', size: {width:300, height:300}}).then(function(base64) {
	      	character_image.setAttribute("value", base64);
	    });		
	}
}