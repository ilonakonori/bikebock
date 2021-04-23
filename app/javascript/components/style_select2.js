const styleSelect2 = () => {
  const request = document.querySelector('#new_request');
  const filter =  document.querySelector('#select-this');

  if(request) {
    request.addEventListener('click', stylePlease);
  }

  if(filter) {
    filter.addEventListener('click',stylePlease);
  }
}

function stylePlease() {
  const el = document.querySelector('.select2-selection--single');
  if(el.classList.contains('open')) {
    el.classList.remove('open');
  } else {
    el.classList.add('open');
  }
}

export { styleSelect2 };
