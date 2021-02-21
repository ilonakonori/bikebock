const initDots = () => {
  function changeColor(class_name, i) {
    const dots = document.getElementsByClassName(class_name);
    while (i > 0) {
      dots[i-1].style.backgroundColor = '#00917C';
      i -= 1;
    }
  }

  const diff = document.getElementById('noD');
  let difficulty = 0;
  if (diff) {
    difficulty += diff.dataset.diffId;
    console.log(difficulty);
  }

  const people = document.getElementById('noP');
  let numberOfPeople = 0;
  if (people) {
    numberOfPeople += people.dataset.peopleId;
    console.log(numberOfPeople);
  }


  changeColor("dot d", difficulty);
  changeColor("dot n", numberOfPeople);
}

export { initDots };
