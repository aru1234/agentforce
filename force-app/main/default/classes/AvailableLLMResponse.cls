@JsonAccess(serializable='always' deserializable='always')
global class AvailableLLMResponse{
    @AuraEnabled
    public List<ResponseAnswer> ResAnswer;
}