@JsonAccess(serializable='always' deserializable='always')
global class ResponseAnswer{
        @AuraEnabled
        public String text;
        @AuraEnabled
        public List<Source> source;
        public ResponseAnswer(String text,List<Source> source){
        
            this.text = text;
            this.source = source;
        }
    }