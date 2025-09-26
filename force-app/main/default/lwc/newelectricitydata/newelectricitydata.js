import { LightningElement,api } from 'lwc';

export default class Newelectricitydata extends LightningElement {
     installationCost;
     perUnitElectricityCost;

  @api
  get value() {
    return this._value;
  }
  /**
   * @param  {} value
   */
  set value(value) {
    this._value = value;
  }


  connectedCallback() {
    console.log('Connected Callback called');
    if (this.value) {
      console.log('Value exists' + this.value);
      console.log('Value exists parseq' + JSON.stringify(this.value));
       const parsedValue = this.value;
        if (parsedValue.plist && Array.isArray(parsedValue.plist) && parsedValue.plist.length > 0) {
          console.log('line 26');
            this.installationCost = parsedValue.plist[0].installationCost;
            this.perUnitElectricityCost = parsedValue.plist[0].perUnitElectricityCost;
   
       
        } else {
            this.installationCost = undefined;
            this.perUnitElectricityCost = undefined;
        }
      console.log('Installation Cost: ' + this.installationCost);
      console.log('Per Unit Electricity Cost: ' + this.perUnitElectricityCost);
    }
  }
}