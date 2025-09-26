public without sharing class ElectricityLoadIncreaseEstimator {
    public class Request {
        @InvocableVariable(required=true)
        public Double additionalLoadKw;
    }

    public class electResponse {
         @InvocableVariable
         public AvailablePrice aprice;
     
    }

     public class AvailablePrice {
        @InvocableVariable
        public List<PriceList> plist;
    }
    public class PriceList {
          @InvocableVariable
        public Double installationCost;
        @InvocableVariable
        public Double perUnitElectricityCost;
        public PriceList(Double installationCost, Double perUnitElectricityCost) {
            this.installationCost = installationCost;
            this.perUnitElectricityCost = perUnitElectricityCost;
        }
    }


    @InvocableMethod(label='Estimate Installation and Electricity Cost' description='Estimates installation and per-unit electricity cost for additional load')
    public static List<electResponse> estimateCosts(List<Request> requests) {
        List<electResponse> results = new List<electResponse>();
         List<PriceList> plist = new List<PriceList>();
        for (Request req : requests) {
            electResponse res = new electResponse();
            PriceList price = new PriceList(
                calculateInstallationCost(req.additionalLoadKw),
                calculatePerUnitCost(req.additionalLoadKw)
            );
            plist.add(price);
        }
        AvailablePrice availablePrice = new AvailablePrice();
        availablePrice.plist = plist;
        electResponse response = new electResponse();
        response.aprice = availablePrice;
        results.add(response);
        return results;
    }

    // Installation cost: $100 per kW
    private static Double calculateInstallationCost(Double kw) {
        return kw * 100;
    }

    // Per-unit electricity cost (sample tiered rates)
    private static Double calculatePerUnitCost(Double kw) {
        if (kw <= 10) {
            return 0.12;
        } else if (kw <= 50) {
            return 0.18;
        } else {
            return 0.08;
        }
    }
}