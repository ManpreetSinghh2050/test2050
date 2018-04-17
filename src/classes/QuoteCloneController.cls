public with sharing class QuoteCloneController {
	Public map<string,quote> quotemap{get;set;}
	public list<quote> quoteList{get;set;}
	
	Public Opportunity OppVar{get;set;}
	public string quoteIdparam{get;set;}
	public QuoteCloneController(ApexPages.StandardController stdController)
	{
		quotemap=new map<string,quote>();
		quoteList=new list<quote>();
		this.OppVar = (Opportunity)stdController.getRecord();
		system.debug(Oppvar.Id);
		for(quote quoteVar:[select id,Name,QuoteNumber,Subtotal,TotalPrice,CreatedBy.Name,ExpirationDate from quote WHERE Opportunity.Id=:Oppvar.Id ORDER BY QuoteNumber DESC ])
		{
			quotemap.put(quoteVar.id,quoteVar);
		}
		if(!quotemap.values().isEmpty())
		{
			quoteList=quotemap.values();
		}
		else
		{
			ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Info,' Opportunity have No quotes To clone '));
		}
		quoteIdparam='';
	} 
	
	Public pageReference quoteCloning()
	{
		quote quoteToClone;
		if(quotemap.containsKey(quoteIdparam))
		{
			quoteToClone=quotemap.get(quoteIdparam);
		}
		sObject quoteToCloneSobj = (sObject) quoteToClone;
		List<sObject> OriginalSobject = new List<sObject>();
		OriginalSobject.add(quoteToCloneSobj);
		List<sObject> clonedSObjects = new List<sObject>();
        clonedSObjects = cloneObjects(OriginalSobject,quoteToClone.getsObjectType());
        Database.Insert((Quote)clonedSObjects.get(0),false);
        PageReference pageRef = new PageReference('/'+clonedSObjects[0].id);
        system.debug('#####'+clonedSObjects[0].id);
        if(cloneQuoteLineItem(quoteIdparam,clonedSObjects[0].id))
        return pageRef;
        else 
        return null;
                                     
	}
	
	public boolean cloneQuoteLineItem(string quoteIdVar,id insertedquoteId)
	{
		List<QuoteLineitem> originalQuoteLineitemList=new List<QuoteLineitem>();
		List<sObject> originalQuoteSObjectsList = new List<sObject>();
		List<sObject> clonedQuoteSObjectsList = new List<sObject>();
		
		 originalQuoteLineitemList = [select Id from QuoteLineitem where quoteid =:quoteIdVar ];
		 system.debug('#####originalQuoteLineitemList'+originalQuoteLineitemList);
		if(originalQuoteLineitemList.isEmpty())
		{
			return true;
		}
		else{
		
		for(quoteLineItem qLI:originalQuoteLineitemList)
		{
			 originalQuoteSObjectsList.add((sObject)qLI);
		}
		 clonedQuoteSObjectsList = QuoteCloneController.cloneObjects(originalQuoteSObjectsList,originalQuoteLineitemList.getsObjectType());
        for(sobject temp:clonedQuoteSObjectsList)   
        {
        	temp.put('quoteid',insertedquoteId);
        	system.debug(temp.get('quoteid'));
        }                         
		
		
		
		Database.insert(clonedQuoteSObjectsList,false);
		return true;
		
		}   
            
	}
	public static List<sObject> cloneObjects(List<sObject> sObjects,Schema.SObjectType objectType)
	{
    // A list of IDs representing the objects to clone
    List<Id> sObjectIds = new List<Id>{};
    // A list of fields for the sObject being cloned
    List<String> sObjectFields = new List<String>{};
    // A list of new cloned sObjects
    List<sObject> clonedSObjects = new List<sObject>{};
    
    // Get all the fields from the selected object type using 
    // the get describe method on the object type.
    if(objectType != null){
      sObjectFields.addAll(
        objectType.getDescribe().fields.getMap().keySet());
    }
    
    // If there are no objects sent into the method, 
    // then return an empty list
    if (sObjects != null && 
        !sObjects.isEmpty() && 
        !sObjectFields.isEmpty()){
    
      // Strip down the objects to just a list of Ids.
      for (sObject objectInstance: sObjects){
        sObjectIds.add(objectInstance.Id);
      }

      /* Using the list of sObject IDs and the object type, 
 we can construct a string based SOQL query 
 to retrieve the field values of all the objects.*/
    
      String allSObjectFieldsQuery = 'SELECT ' + sObjectFields.get(0); 
    
      for (Integer i=1 ; i < sObjectFields.size() ; i++){
        allSObjectFieldsQuery += ', ' + sObjectFields.get(i);
      }
    
      allSObjectFieldsQuery += ' FROM ' + 
                               objectType.getDescribe().getName() + 
                               ' WHERE ID IN (\'' + sObjectIds.get(0) + 
                               '\'';

      for (Integer i=1 ; i < sObjectIds.size() ; i++){
        allSObjectFieldsQuery += ', \'' + sObjectIds.get(i) + '\'';
      }
    
      allSObjectFieldsQuery += ')';
    
      try{
      
        // Execute the query. For every result returned, 
        // use the clone method on the generic sObject 
        // and add to the collection of cloned objects
        for (SObject sObjectFromDatabase:
             Database.query(allSObjectFieldsQuery)){
          clonedSObjects.add(sObjectFromDatabase.clone(false,true));  
        }
    
      } catch (exception e){
        // Write exception capture method 
        // relevant to your organisation. 
        // Debug message, Apex page message or 
        // generated email are all recommended options.
      }
    }    
    
    // return the cloned sObject collection.
    return clonedSObjects;
  }
    
}