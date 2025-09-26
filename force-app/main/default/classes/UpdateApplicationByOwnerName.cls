public with sharing class UpdateApplicationByOwnerName {

    public class Request {
        @InvocableVariable(required=true)
        public String applicationName;

        @InvocableVariable(required=true)
        public Decimal newConnectionLoad;

        @InvocableVariable(required=true)
        public Decimal newUnitCost;
    }
    
    public class Response {
        @InvocableVariable(required=true)
        public Boolean updateSuccessful;

    }

    @InvocableMethod(
        label='Update Application by Name and Owner'
        description='Find Application__c records by name and user name (owner), then update load and cost'
    )
    public static List<Response> updateApplications(List<Request> requests) {
        List<Application__c> appsToUpdate = new List<Application__c>();
             List<Response> res = new List<Response>();

        for (Request req : requests) {
            if (String.isNotBlank(req.applicationName)) {
                // Query applications that match application name and user name using LIKE
                List<Application__c> matchingApps = [
                    SELECT Id, Name, Connection_Load__c, Unit_Cost__c, Owner.Name
                    FROM Application__c
                    WHERE Name = :req.applicationName
                ];

                for (Application__c app : matchingApps) {
                    app.Connection_Load__c = req.newConnectionLoad;
                    app.Unit_Cost__c = req.newUnitCost;
                    appsToUpdate.add(app);
                }
            }
        }

        if (!appsToUpdate.isEmpty()) {
             Response res1 = new Response();
            try{
            update appsToUpdate;
                res1.updateSuccessful=true;

            }
            catch(DmlException e){
             res1.updateSuccessful=false;

            }
            res.add(res1);
        }
        return res;
    }
}