import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ 'notification' ];

  connect() {
    setInterval(this.refresh, 5000);
  }

  refresh = () => {
    fetch('/users/unread', { headers: { accept: "application/json" } } )
      .then(response => response.json())
      .then((data) => {
        if(data.notifications) {
          this.notificationTarget.innerText = data.notifications;
        }
        console.log(data.notifications);
      });
  }
}
