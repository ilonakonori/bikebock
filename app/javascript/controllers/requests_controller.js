import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ 'request' ];

  connect() {
    setInterval(this.refresh, 5000);
  }

  refresh = () => {
    fetch('/users/unread', { headers: { accept: "application/json" } } )
      .then(response => response.json())
      .then((data) => {
        if(data.requests) {
          this.requestTarget.innerText = data.requests;
        }
        console.log(data.requests);
      });
  }
}
