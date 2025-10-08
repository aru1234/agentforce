@JsonAccess(serializable='always' deserializable='always')
global class Claim {
    @AuraEnabled
    global String name;

    @AuraEnabled
    global String description;

    @AuraEnabled
    global String claimType;

    @AuraEnabled
    global Date claimDate;

    @AuraEnabled
    global String policyNumber;

    @AuraEnabled
    global String contact;

    global Claim(String name,String description,String claimType, Date claimDate, String policyNumber, String contact){
        this.name=name;
        this.description=description;
        this.claimType=claimType;
        this.claimDate=claimDate;
        this.policyNumber=policyNumber;
        this.contact=contact;
    }
}