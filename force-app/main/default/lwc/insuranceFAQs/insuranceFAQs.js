import { LightningElement,api } from 'lwc';

export default class InsuranceFAQs extends LightningElement {

    text;
    // source;

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

    connectedCallback(){
        console.log('Connected Callback called.');
        if(this.value){
            console.log('value exists '+this.value);
            console.log('parsed value '+JSON.stringify(this.value));
            const parsedValue = this.value;
            if(parsedValue.ResAnswer && Array.isArray(parsedValue.ResAnswer) && parsedValue.ResAnwer.length > 0) {
                this.text = parsedValue.ResAnswer[0].text;
                this.source = parsedValue.ResAnswer[0].source[0].source_Id;
            } else {
                this.text = undefined;
                this.source = undefined;
            }
            
            console.log('text '+this.text); 
            console.log('source '+this.source);

        }
    }
}