public with sharing class MassInsertOpp {
	
    
    //TX
    public static void insertOppTX(){
    	
    	List<Account> accList     = [SELECT Id, Name FROM Account Where Name = 'TestAccount'];
    	List<Opportunity> oppList = new List<Opportunity>();
    	
    	for(Integer i=0; i<11 ; i++){
	    	Opportunity opp = new Opportunity();
	    	opp.Name = 'Kovac opp TX '+i;
	    	opp.AccountId = accList[0].Id;
	    	opp.StageName = 'Prospecting';
	    	opp.CloseDate = Date.Today();
	    	opp.Opportunity_State__c = 'TX';
	    	opp.Opportunity_City_text_area__c = 'Testcity';
	    	opp.G_Est_Start_Date__c = Date.Today();
	    	opp.Field_Completion_Date__c = Date.Today(); 
	    	
	    	oppList.add(opp);
    	}
    	System.debug('@@@@ List<Opportunity> oppList TX:'+oppList);
		
		//insert
		try{
			if(!oppList.isEmpty()){
				insert oppList;
			}
		}
		catch(exception e){}	        

    }
    
    
    //AZ
    public static void insertOppAZ(){

    	List<Account> accList     = [SELECT Id, Name FROM Account Where Name = 'TestAccount'];
    	List<Opportunity> oppList = new List<Opportunity>();
    	
    	for(Integer i=0; i<11 ; i++){
	    	Opportunity opp = new Opportunity();
	    	opp.Name = 'Kovac opp AZ '+i;
	    	opp.AccountId = accList[0].Id;
	    	opp.StageName = 'Prospecting';
	    	opp.CloseDate = Date.Today();
	    	opp.Opportunity_State__c = 'AZ';
	    	opp.Opportunity_City_text_area__c = 'Testcity';
	    	opp.G_Est_Start_Date__c = Date.Today();
	    	opp.Field_Completion_Date__c = Date.Today(); 
	    	
	    	oppList.add(opp);
    	}
    	System.debug('@@@@ List<Opportunity> oppList AZ:'+oppList);
		
		//insert
		try{
			if(!oppList.isEmpty()){
				insert oppList;
			}
		}
		catch(exception e){}	        

    }
    
    
    //CA
    public static void insertOppCA(){
    	
    	List<Account> accList     = [SELECT Id, Name FROM Account Where Name = 'TestAccount'];
    	List<Opportunity> oppList = new List<Opportunity>();
    	
    	for(Integer i=0; i<11 ; i++){
	    	Opportunity opp = new Opportunity();
	    	opp.Name = 'Kovac opp CA '+i;
	    	opp.AccountId = accList[0].Id;
	    	opp.StageName = 'Prospecting';
	    	opp.CloseDate = Date.Today();
	    	opp.Opportunity_State__c = 'CA';
	    	opp.Opportunity_City_text_area__c = 'Testcity';
	    	opp.G_Est_Start_Date__c = Date.Today();
	    	opp.Field_Completion_Date__c = Date.Today(); 
	    	
	    	oppList.add(opp);
    	}
    	System.debug('@@@@ List<Opportunity> oppList CA:'+oppList);
		
		//insert
		try{
			if(!oppList.isEmpty()){
				insert oppList;
			}
		}
		catch(exception e){}	        

    }
    
    
    //TN
    public static void insertOppTN(){
    	
    	List<Account> accList     = [SELECT Id, Name FROM Account Where Name = 'TestAccount'];
    	List<Opportunity> oppList = new List<Opportunity>();
    	
    	for(Integer i=0; i<11 ; i++){
	    	Opportunity opp = new Opportunity();
	    	opp.Name = 'Kovac opp TN '+i;
	    	opp.AccountId = accList[0].Id;
	    	opp.StageName = 'Prospecting';
	    	opp.CloseDate = Date.Today();
	    	opp.Opportunity_State__c = 'TN';
	    	opp.Opportunity_City_text_area__c = 'Testcity';
	    	opp.G_Est_Start_Date__c = Date.Today();
	    	opp.Field_Completion_Date__c = Date.Today(); 
	    	
	    	oppList.add(opp);
    	}
    	System.debug('@@@@ List<Opportunity> oppList TN:'+oppList);
		
		//insert
		try{
			if(!oppList.isEmpty()){
				insert oppList;
			}
		}
		catch(exception e){}	        

    }
    
    
    //OR
    public static void insertOppOR(){
    	
    	List<Account> accList     = [SELECT Id, Name FROM Account Where Name = 'TestAccount'];
    	List<Opportunity> oppList = new List<Opportunity>();
    	
    	for(Integer i=0; i<11 ; i++){
	    	Opportunity opp = new Opportunity();
	    	opp.Name = 'Kovac opp OR '+i;
	    	opp.AccountId = accList[0].Id;
	    	opp.StageName = 'Prospecting';
	    	opp.CloseDate = Date.Today();
	    	opp.Opportunity_State__c = 'OR';
	    	opp.Opportunity_City_text_area__c = 'Testcity';
	    	opp.G_Est_Start_Date__c = Date.Today();
	    	opp.Field_Completion_Date__c = Date.Today(); 
	    	
	    	oppList.add(opp);
    	}
    	System.debug('@@@@ List<Opportunity> oppList OR:'+oppList);
		
		//insert
		try{
			if(!oppList.isEmpty()){
				insert oppList;
			}
		}
		catch(exception e){}	        

    }
    
    
    //WA
    public static void insertOppWA(){
    	
    	List<Account> accList     = [SELECT Id, Name FROM Account Where Name = 'TestAccount'];
    	List<Opportunity> oppList = new List<Opportunity>();
    	
    	for(Integer i=0; i<11 ; i++){
	    	Opportunity opp = new Opportunity();
	    	opp.Name = 'Kovac opp WA '+i;
	    	opp.AccountId = accList[0].Id;
	    	opp.StageName = 'Prospecting';
	    	opp.CloseDate = Date.Today();
	    	opp.Opportunity_State__c = 'WA';
	    	opp.Opportunity_City_text_area__c = 'Testcity';
	    	opp.G_Est_Start_Date__c = Date.Today();
	    	opp.Field_Completion_Date__c = Date.Today(); 
	    	
	    	oppList.add(opp);
    	}
    	System.debug('@@@@ List<Opportunity> oppList WA:'+oppList);
		
		//insert
		try{
			if(!oppList.isEmpty()){
				insert oppList;
			}
		}
		catch(exception e){}	        

    }
}