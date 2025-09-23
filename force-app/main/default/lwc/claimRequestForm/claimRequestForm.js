import { api, LightningElement } from "lwc";
// import { createRecord } from 'lightning/uiRecordApi';
// import { ShowToastEvent } from 'lightning/platformShowToastEvent';
// import CLAIM_OBJECT from "@salesforce/schema/Claim__c";

// import NAME_FIELD from "@salesforce/schema/Claim__c.Name";
// import DESCRIPTION_FIELD from "@salesforce/schema/Claim__c.Description__c";
// import TYPE_FIELD from "@salesforce/schema/Claim__c.Claim_Type__c";
// import DATE_FIELD from "@salesforce/schema/Claim__c.Claim_Date__c";


export default class FlightFilter extends LightningElement {
   
  @api
  get readOnly() {
    return this._readOnly;
  }

  set readOnly(value) {
    this._readOnly = value;
  }
  _readOnly = false;
  _value;
  @api
  get value() {
    return this._value;
  }
  set value(value) {
    this._value = value;
  }
  name;
  description;
  claimType;
  claimDate;
  //claimId;

  connectedCallback() {
    if (this.value) {
      this.name = this.value?.name || "";
      this.description = this.value?.description || "";
      this.claimType = this.value?.claimType || "";
      this.claimDate = this.value?.claimDate || "";
    }
  }
  handleInputChange(event) {
    event.stopPropagation();
    const { name, value } = event.target;
    this[name] = value;

  console.log("name==>", this.name);
  console.log("description==>", this.description);
  console.log("claimType==>", this.claimType);
  console.log("claimDate==>", this.claimDate);
    
  

    this.dispatchEvent(
      new CustomEvent("valuechange", {
        detail: {
          value: {
            name: this.name,
            description: this.description,
            claimType: this.claimType,
            claimDate: this.claimDate,
          },
        },
      }),
    );
  }
  // handleClick() {
  
  //   //3. Map the data to the fields
  //   const fields = {};

  //   fields[NAME_FIELD.fieldApiName] = this.name;
  //   fields[DESCRIPTION_FIELD.fieldApiName] = this.description;
  //   fields[TYPE_FIELD.fieldApiName] = this.claimType;
  //   fields[DATE_FIELD.fieldApiName] = this.claimDate;
        
  //       //4. Prepare config object with object and field API names 
  //   const recordInput = {
  //     apiName: CLAIM_OBJECT.objectApiName,
  //     fields: fields
  //   };
        
  //       //5. Invoke createRecord by passing the config object
  //   const claim = createRecord(recordInput).then((record) => {
    
  //     console.log(record);
  //      this.dispatchEvent(
  //                   new ShowToastEvent({
  //                       title: 'Success',
  //                       message: 'Account created',
  //                       variant: 'success',
  //                   }),
  //               );
  //   }).catch(error=>{
  //     this.dispatchEvent(
  //                   new ShowToastEvent({
  //                       title: 'Error creating record',
  //                       message: error.body.message,
  //                       variant: 'error',
  //                   }),
  //               );
  //   });
  // }
}