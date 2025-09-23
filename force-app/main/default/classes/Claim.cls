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

    global Claim(String name,String description,String claimType, Date claimDate){
        this.name=name;
        this.description=description;
        this.claimType=claimType;
        this.claimDate=claimDate;
    }
}