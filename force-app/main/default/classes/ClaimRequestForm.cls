@JsonAccess(serializable='always' deserializable='always')
global class ClaimRequestForm {
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


}