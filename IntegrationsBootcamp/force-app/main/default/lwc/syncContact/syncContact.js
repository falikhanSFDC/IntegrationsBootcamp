import { LightningElement, api, track } from "lwc";
import syncContact from "@salesforce/apex/SyncContactController.syncContact";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class SyncContact extends LightningElement {
  @api recordId;
  @track error;
  _title;
  message;
  variant;
  variantOptions = [
    { label: "error", value: "error" },
    { label: "warning", value: "warning" },
    { label: "success", value: "success" },
    { label: "info", value: "info" },
  ];
  @api invoke() {
    syncContact({ contactId: this.recordId })
      .then((result) => {
        this._title = "Success";
        this.message = "Contact updated in external system";
        this.variant = "success";
        this.showNotification();
      })
      .catch((error) => {
        this.error = error;
        this._title = "Error";
        this.message = error.message;
        this.variant = "error";
        this.showNotification();
      });
  }

  showNotification() {
    const evt = new ShowToastEvent({
      title: this._title,
      message: this.message,
      variant: this.variant,
    });
    this.dispatchEvent(evt);
  }
}
