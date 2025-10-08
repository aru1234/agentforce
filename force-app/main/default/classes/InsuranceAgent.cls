global class InsuranceAgent {
    @InvocableMethod(label='Fill Claim Form' description='Fill Claim Form')
    global static List<ClaimResponse> fillClaimForm (List<ClaimRequest> req) {
        
        
        List<Claim__c> claimsToInsert = new List<Claim__c>();
        List<Claim> claims = new List<Claim>();
        for(ClaimRequest cr : req) {
            ClaimRequestForm crf = cr.claimForm;
            Claim__c claim = new Claim__c();

            claim.Name = crf.name;
            claim.Description__c = crf.description;
            claim.Claim_Type__c = crf.claimType;
            claim.Claim_Date__c = crf.claimDate;
            claim.Policy_Number__c = crf.policyNumber;
            claim.Status__c = 'New';
            List<Policy__c> policies = [SELECT Id, contact__c, contact__r.Phone FROM Policy__c WHERE Policy_Number__c = :crf.policyNumber];
            if(policies.size() > 0){
                claim.Policy__c = policies[0].Id;
                claim.Contact__c = policies[0].Contact__c;
                claimsToInsert.add(claim);
                Claim claimSub = new Claim(crf.name,crf.description,crf.claimType,crf.claimDate,crf.policyNumber,policies[0].Contact__r.Phone);
                claims.add(claimSub);
            } else {
                Claim claimSub = new Claim(crf.name,crf.description,crf.claimType,crf.claimDate,crf.policyNumber,policies[0].Contact__r.Phone);
                claims.add(claimSub);

            }

            
        }
        if(claimsToInsert.size() > 0){
            insert claimsToInsert;
        }
        
        List<ClaimResponse> claimResponses = new List<ClaimResponse>();

        // For example, we hardcode the data and don’t focus on how we retrieve it.
        // However, consider that we receive available flight data from a service
        // and then iterate through the data to generate the final response.

       
        // Claim c1 = new Claim('Mainsh Kumar', 'Bike Accident', 'Medical');
        // Flight f2 = new Flight('6E 488', 2, false, 2000l, 15.15d, 120);
        // Flight f3 = new Flight('6E 523', 1, false, 3000l, 13.14d, 75);
        // Flight f4 = new Flight('6E 6166', 2, false, 4000l, 14.14d, 130);
        // claims.add(c1);  
        // flights.add(f2); flights.add(f3); flights.add(f4);
        ExistingClaim existingClaims = new ExistingClaim();
        existingClaims.claims = claims;

        ClaimResponse cr = new ClaimResponse();
        cr.eClaim = existingclaims;
        claimResponses.add(cr);

        return claimResponses;
    }
@JsonAccess(serializable='always' deserializable='always')
global class ClaimRequest {
//     @InvocableVariable
//     global String name;

//    @InvocableVariable
//     global String description;

//     @InvocableVariable
//     global String claimType;

//     @InvocableVariable
//     global Date claimDate;

    @InvocableVariable
    global ClaimRequestForm claimForm;


 }
    @JsonAccess(serializable='always' deserializable='always')
    global class ClaimResponse {
     @InvocableVariable
     global ExistingClaim eClaim;
   }
}