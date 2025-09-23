public with sharing class InsuranceFAQs {

	public class Request {
		@InvocableVariable (required=true)
		public String question;
	}
	
	public class Response {
		@InvocableVariable 
		public LLMResponse answer;
	}
    
	@InvocableMethod(label='Insurance FAQs' description='Insurance Related FAQs')
	public static List<Response> getAnswerToFAQs (List<Request> requests){
	
	List<Response> results = new List<Response>();
	
	for(Request req : requests){
		Response res = new Response();
		res.answer = invokePromptTemplate(req.question);
        system.debug('res.answer-->'+res.answer);
		results.add(res);
	}
	return results;
	
	}
	
	private static LLMResponse invokePromptTemplate(String questionStr){
		ConnectApi.WrappedValue questionWrappedValue = new ConnectApi.WrappedValue();
        questionWrappedValue.value = questionStr;
        
     	ConnectApi.WrappedValue retrieverIdWrappedValue = new ConnectApi.WrappedValue();
        retrieverIdWrappedValue.value = 'Default_FileUDMO_SI_Retriever_1Cx_9np1d4ad739';
        
        Map<String, ConnectApi.WrappedValue> inputParams = new Map<String, ConnectApi.WrappedValue>();
  		inputParams.put('Input:Query', questionWrappedValue);      
		inputParams.put('Input:RetrieverIdOrName', retrieverIdWrappedValue);

        // Configure invocation parameters
        ConnectApi.EinsteinPromptTemplateGenerationsInput executeTemplateInput = new ConnectApi.EinsteinPromptTemplateGenerationsInput();
        executeTemplateInput.additionalConfig = new ConnectApi.EinsteinLlmAdditionalConfigInput();
        executeTemplateInput.additionalConfig.applicationName = 'PromptBuilderPreview';
        executeTemplateInput.isPreview = false;
        executeTemplateInput.inputParams = inputParams;
        
       try {
            // Call the service
            ConnectApi.EinsteinPromptTemplateGenerationsRepresentation generationsOutput = ConnectApi.EinsteinLLM.generateMessagesForPromptTemplate(
                'einstein_gpt__answerWithKnowledge',
                executeTemplateInput
            );
            ConnectApi.EinsteinLLMGenerationItemOutput response = generationsOutput.generations[0];
            System.debug('response==>'+response.text);
           	return (LLMResponse) JSON.deserialize(response.text,LLMResponse.class);
            
            
			
        } catch (Exception e) {
            System.debug(e.getMessage());
            return null;
            //throw e;
        }
 	}
    
    public class LLMResponse{
       @InvocableVariable
		public ResponseLLM response;
    }
    public class ResponseLLM{
    //     @AuraEnabled
    //     public String text;
    //    @AuraEnabled
    //     public List<Source> source;
        @InvocableVariable
        public List<AnsRes> ans;
    }
    public class AnsRes{
        @InvocableVariable
        public String text; 
        // @AuraEnabled
        // public String source;
    }
    
    
}