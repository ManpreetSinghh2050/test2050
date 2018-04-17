public with sharing class ContractPDF {
    
    string OpportunityId='';
    public list<FillAccountOpportunityObject> listContractPDFWrapper {get;set;}
    
    public ContractPDF(){
    	
    	listContractPDFWrapper = new list<FillAccountOpportunityObject>();
    	
    	if(ApexPages.currentPage().getParameters().containsKey('id')){
    		OpportunityId=String.escapeSingleQuotes(ApexPages.currentPage().getParameters().get('id'));
    		if(OpportunityId!=null && OpportunityId!=''){
    			list<Opportunity> OppList = [select id, AccountId, name from Opportunity where id = :OpportunityId];
    			if(!OppList.isEmpty()){
    				list<Account> AccList = [select id, name from Account where id = :OppList[0].AccountId];
    				if(!AccList.isEmpty()){
    					listContractPDFWrapper.add(new FillAccountOpportunityObject(OppList[0],AccList[0]));
    				}
    			}
    		}
    	}
    }
    
    public class FillAccountOpportunityObject{
    	
    	public Account Acc {get;set;}
    	public Opportunity Opp {get;set;}
    	
    	public FillAccountOpportunityObject(Opportunity Oppty,Account Acct){
    		Acc = Acct;
    		Opp = Oppty;
    	}
    	
    }
    
}