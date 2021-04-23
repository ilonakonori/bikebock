import $ from 'jquery';
import 'select2';

const initSelect2 = () => {
  $('.select2').select2({
    theme: `${document.cookie.replace('theme=', '')}`
  });
};

export { initSelect2 };
