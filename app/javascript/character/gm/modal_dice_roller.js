diceRoller = document.getElementById('diceRoller')
diceRoller.addEventListener('show.bs.modal', event => {
  const button = event.relatedTarget;
  
  const name = button.getAttribute('data-bs-name');
  const image = button.getAttribute('data-bs-image');
  const id = button.getAttribute('data-bs-id');

  const modalTitle = diceRoller.querySelector('.modal-title');
  const nameInput = diceRoller.querySelector('#name');
  const idInput = diceRoller.querySelector('#characterId');
  const imageInput = diceRoller.querySelector('#characterImage');

  const srcImage = document.getElementById(image);

  modalTitle.textContent = name;
  nameInput.value = name;
  idInput.value = id;

  if (srcImage === null){
    imageInput.value = "";
  } else {
    imageInput.value = srcImage.src;
  }
})