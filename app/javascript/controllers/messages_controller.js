import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ 'message' ];

  connect() {
    setInterval(this.refresh, 5000);
  }

  refresh = () => {
    fetch('/users/unread', { headers: { accept: "application/json" } } )
      .then(response => response.json())
      .then((data) => {
        if(data.messages > 0) {
          this.messageTarget.innerText = data.messages;
        }
        console.log(data.messages);
      });
  }
}
