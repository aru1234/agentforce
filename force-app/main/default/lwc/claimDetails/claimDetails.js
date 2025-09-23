import { LightningElement,api } from 'lwc';

export default class ClaimDetails extends LightningElement {

    name;
    description;
    claimType;
    claimDate;

    @api
    get value(){
        return this._value;
    }

    set value(value){
        this._value = value;
    }

    connectedCallback(){
        console.log('Connected Callback called');
        if(this.value){
            console.log('Value exists' + this.value);
            console.log('Value exists parseq' + JSON.stringify(this.value));
            const parsedValue = this.value;
            if(parsedValue.claims && Array.isArray(parsedValue.claims)&&parsedValue.claims.length>0){
                this.name = parsedValue.claims[0].name;
                this.description = parsedValue.claims[0].description;
                this.claimType = parsedValue.claims[0].claimType;
                this.claimDate = parsedValue.claims[0].claimDate;
            } else {
                this.name = undefined;
                this.description = undefined;
                this.claimType = undefined;
                this.claimDate = undefined;
            }
            console.log("name:"+this.name);
            console.log("description:"+this.description);
            console.log("claimType:"+this.claimType);
            console.log("claimDate:"+this.claimDate);
        }
    }
}