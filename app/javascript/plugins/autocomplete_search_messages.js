import 'js-autocomplete/auto-complete.css';
import autocomplete from 'js-autocomplete';

const autocompleteSearchMessages = function() {
  const messages = document.getElementById('search-msgs-data');
  const searchInput = document.getElementById('mySearch');

  if(messages && searchInput) {
    new autocomplete({
      selector: searchInput,
      minChars: 1,
      source: function(term, suggest){
        term = term.toLowerCase();
        const choices = JSON.parse(messages.dataset.messages);
        const matches = [];
        for (let i = 0; i < choices.length; i++)
          if (~choices[i].toLowerCase().indexOf(term)) matches.push(choices[i]);
        suggest(matches);
      },
      onSelect: function(e, term, item) {
        document.getElementById('mySubmit').click();
      }
    });
  }
};

export { autocompleteSearchMessages };
