import 'js-autocomplete/auto-complete.css';
import autocomplete from 'js-autocomplete';

const autocompleteSearchConversations = function() {
  const conversations = document.getElementById('search-data');
  const searchInput = document.getElementById('myConversationSearch');

  if(conversations && searchInput) {
    new autocomplete({
      selector: searchInput,
      minChars: 1,
      source: function(term, suggest){
        term = term.toLowerCase();
        const choices = JSON.parse(conversations.dataset.conversations);
        const matches = [];
        for (let i = 0; i < choices.length; i++)
          if (~choices[i].toLowerCase().indexOf(term)) matches.push(choices[i]);
        suggest(matches);
      },
    });
  }
};

export { autocompleteSearchConversations };
