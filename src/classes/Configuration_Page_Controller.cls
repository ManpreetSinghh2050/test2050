public with sharing class Configuration_Page_Controller {
Public Opportunity OppVar{get;set;}
Public OpportunityLineItem Oli{get;set;}
public decimal Metalamount{get;set;}
public decimal Glassamount{get;set;}

public boolean flag{get;set;}
//public boolean formFlag{get;set;}
public map<string,config_Wrapper> glassWrapperMap{get;set;}
public map<string,config_Wrapper> metalWrapperMap{get;set;}
public string buttonSwap{get;set;}
public Map<String, Schema.SObjectField> fieldMap;
//public boolean disableButton{get;set;}
Public set<string> glassSort{get;set;}
public set<string> metalSort{get;set;}
public string oppIdentity;


//Constructor definition of Configuration_Page_Controller
Public Configuration_Page_Controller()
{
    OppVar=new Opportunity();
    Oli= new OpportunityLineItem();
    buttonSwap='';
    //fieldsApi=new List<string>();
    flag=false;
    //formFlag=true;
    //disableButton=true;
    Metalamount=0.0;
    Glassamount=0.0;

    glassWrapperMap=new map<string,config_Wrapper>();
    metalWrapperMap=new map<string,config_Wrapper>();
    glassSort=new set<string>();
    metalSort=new set<string>();
    oppIdentity='';
    
}

//Populating values of selected Opportunity 
public void getingValues()
{
     flag=false;     
     string query='';
     List<API_Indexing__c>  apiFieldsCs=new  List<API_Indexing__c> ();
     apiFieldsCs=API_Indexing__c.getAll().values();
     String coma='';
     for(API_Indexing__c strVar:apiFieldsCs)
     {
        query+=coma+strVar.GlassApiName__c+','+strVar.MetalApiName__c;
        coma=',';
     }
     
     query='select id,Glass_Price__c,Metal_Price__c,Field_Completion_Date__c,G_Est_Start_Date__c,G_Est_Completion_Date__c,M_Est_Start_Date__c,M_Est_Completion_Date__c,'+' '+query+' '+'From Opportunity where id=\''+oli.opportunityid+'\'';
    
    
    OppVar=database.query(query);
    oppIdentity=identifyOpportunity(oli.opportunityid);
    
    Glassamount=OppVar.Glass_Price__c;
    Metalamount=OppVar.Metal_Price__c	;
    showPanel();
    
}

//function to get map of api name vs sobject field to show label on vf page "opportunity_configuration_page"
public static Map<String, Schema.SObjectField> gettingLabel( string objectName)
{
    List<Schema.DescribeSObjectResult> describeSobjectsResult = Schema.describeSObjects(new List<String>{objectName}); // this can accept list of strings, we describe only one object here
    System.debug(describeSobjectsResult);
    String objectLabel = describeSobjectsResult[0].getLabel();
    Map<String, Schema.SObjectField> allFields = describeSobjectsResult[0].fields.getMap();
    return allfields;
    
}

// function to show panel with dynamic fields of glass and metal on click of config button
public void showPanel()
{      
      
      if(oppIdentity=='Both')
      {
      if(Glassamount==null || Glassamount<=0)
      {
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Opportunity have no Glass amount assigned please contact your administrator '));
      }
      else if(Metalamount==null || Metalamount<=0)
      {
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Opportunity have no Metal amount assigned please contact your administrator '));
      }
      else if(OppVar.G_Est_Start_Date__c==null )
      {
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Opportunity have no Start Date assigned for glass please contact your administrator '));
      }
      
      else if(OppVar.M_Est_Start_Date__c==null )
      {
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Opportunity have no Start Date assigned For metal please contact your administrator '));
      }
      
      else if(oppVar.Field_Completion_Date__c==null )
      {
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Opportunity have no End Date assigned please contact your administrator '));
      }
      else if(oppVar.Field_Completion_Date__c<OppVar.G_Est_Start_Date__c)
      {
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,' End Date Must be Greater than or equal to start date '));
      }
      
      else if(oppVar.Field_Completion_Date__c<OppVar.M_Est_Start_Date__c)
      {
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,' End Date Must be Greater than or equal to start date '));
      }
      else if (Opportunity_Year_Index__c.getInstance(string.valueof(OppVar.G_Est_Start_Date__c.year())) == null ||Opportunity_Year_Index__c.getInstance(string.valueof(OppVar.M_Est_Start_Date__c.year()))==null)
      {
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,' Start Date on Opportunity is not in bound please contact your administrator'));
      }
      else if (Opportunity_Year_Index__c.getInstance(string.valueof(OppVar.Field_Completion_Date__c.year()))==null )
      {
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,' End Date on Opportunity is not in bound please contact your administrator'));
      }
       else
      {
        glassSort=new set<string>();
        metalSort=new set<string>();
        
        List<API_Indexing__c>  boundDateApiNames=new  List<API_Indexing__c> ();                                       
        boundDateApiNames = OpptyChartController.getIndexApiList(OppVar.G_Est_Start_Date__c,OppVar.Field_Completion_Date__c);
        
        fieldMap=new Map<String, Schema.SObjectField>();
        fieldMap=gettingLabel('Opportunity');
        system.debug('****boundDateApiNames'+boundDateApiNames);
        if(boundDateApiNames.size()>24 ||boundDateApiNames.size()<0)
        {
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,' Month Difference is Greater than 24 months For Glass'));
             return;
        }
        List<MonthlyPercentage__c> monthPercentage=new List<MonthlyPercentage__c>();
        monthPercentage=[select name,Month1__c,Month2__c,Month3__c,Month4__c,Month5__c,Month6__c,Month7__c,Month8__c,Month9__c,
                        Month10__c,Month11__c,Month12__c,Month13__c,Month14__c,Month15__c,Month16__c,Month17__c,Month18__c,Month19__c,Month20__c,
                        Month21__c,Month22__c,Month23__c,Month24__c from MonthlyPercentage__c where Difference__c=:boundDateApiNames.size() ];
        
        string str='';
        integer i=1;                
        for(API_Indexing__c apiIndex:boundDateApiNames)
        {
            
            str='Month'+i+'__c';
            glassSort.add(apiIndex.GlassApiName__c);
       
            glassWrapperMap.put(apiIndex.GlassApiName__c,new config_Wrapper(fieldMap.get(apiIndex.GlassApiName__c).getDescribe().getLabel(),oppVar.Glass_Price__c,apiIndex.GlassApiName__c,(Decimal)monthPercentage[0].get(str)));
            //metalWrapperMap.put(apiIndex.MetalApiName__c,new config_Wrapper(fieldMap.get(apiIndex.MetalApiName__c).getDescribe().getLabel(),oppVar.Metal_Price__c,apiIndex.MetalApiName__c,(Decimal)monthPercentage[0].get(str)));
            i++;
        }
        
        List<MetalMonthlyPercentage__c> metalMonthPercent=new List<MetalMonthlyPercentage__c>();
        //glassWrapperMap=gettingMapValues(boundDateApiNames,monthPercentage,'glass');
        boundDateApiNames=new List<API_Indexing__c>();
        system.debug('%%%%boundDateApiNames'+boundDateApiNames.size()); 
        boundDateApiNames = OpptyChartController.getIndexApiList(OppVar.M_Est_Start_Date__c,OppVar.Field_Completion_Date__c);
        if(boundDateApiNames.size()>24 ||boundDateApiNames.size()<0)
        {
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,' Month Difference is Greater than 24 months For Metal'));
             return;
        }
        flag=true;
        //monthPercentage=new List<MonthlyPercentage__c>();
        metalMonthPercent=[select name,Month1__c,Month2__c,Month3__c,Month4__c,Month5__c,Month6__c,Month7__c,Month8__c,Month9__c,
                        Month10__c,Month11__c,Month12__c,Month13__c,Month14__c,Month15__c,Month16__c,Month17__c,Month18__c,Month19__c,Month20__c,
                        Month21__c,Month22__c,Month23__c,Month24__c from MetalMonthlyPercentage__c where Difference__c=:boundDateApiNames.size()    ];
            
            
        str='';
        i=1;    
            for(API_Indexing__c apiIndex:boundDateApiNames)
        {
            
            str='Month'+i+'__c';
            
            metalSort.add(apiIndex.MetalApiName__c);
            //glassWrapperMap.put(apiIndex.GlassApiName__c,new config_Wrapper(fieldMap.get(apiIndex.GlassApiName__c).getDescribe().getLabel(),oppVar.Glass_Price__c,apiIndex.GlassApiName__c,(Decimal)monthPercentage[0].get(str)));
            metalWrapperMap.put(apiIndex.MetalApiName__c,new config_Wrapper(fieldMap.get(apiIndex.MetalApiName__c).getDescribe().getLabel(),oppVar.Metal_Price__c,apiIndex.MetalApiName__c,(Decimal)metalMonthPercent[0].get(str)));
            i++;
        }
            
            
                
        //metalWrapperMap=gettingMapValues(boundDateApiNames,monthPercentage,'metal');
        system.debug('%%%%metalWrapperMap'+metalWrapperMap);
        
    //Must be a method Separately called from Show panel Method
   // wrapperMap.put('Jan_17_G__c',new config_Wrapper() );
        /*for(API_Indexing__c apiIndex:boundDateApiNames)
        {
            
            str='Month'+i+'__c';
            glassSort.add(apiIndex.GlassApiName__c);
            metalSort.add(apiIndex.MetalApiName__c);
            glassWrapperMap.put(apiIndex.GlassApiName__c,new config_Wrapper(fieldMap.get(apiIndex.GlassApiName__c).getDescribe().getLabel(),oppVar.Glass_Price__c,apiIndex.GlassApiName__c,(Decimal)monthPercentage[0].get(str)));
            metalWrapperMap.put(apiIndex.MetalApiName__c,new config_Wrapper(fieldMap.get(apiIndex.MetalApiName__c).getDescribe().getLabel(),oppVar.Metal_Price__c,apiIndex.MetalApiName__c,(Decimal)monthPercentage[0].get(str)));
            i++;
        }*/
        system.debug('****glassWrapperMap'+glassWrapperMap.keyset());
        
        
        
        //PreviewPercentage();
        
      }
      }
       else if(oppIdentity=='Metal')
       {
       	if(Metalamount==null || Metalamount<=0)
      	{
        	ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Opportunity have no Metal amount assigned please contact your administrator '));
     	 }
     	 else if(OppVar.M_Est_Start_Date__c==null )
      		{
       			 ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Opportunity have no Start Date assigned For metal please contact your administrator '));
      		}
      		
      	else if(oppVar.Field_Completion_Date__c<OppVar.M_Est_Start_Date__c)
      	{
        	ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,' End Date Must be Greater than or equal to start date '));
      	}
      else if (Opportunity_Year_Index__c.getInstance(string.valueof(OppVar.M_Est_Start_Date__c.year()))==null)
      {
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,' Start Date on Opportunity is not in bound please contact your administrator'));
      }
      else if (Opportunity_Year_Index__c.getInstance(string.valueof(OppVar.Field_Completion_Date__c.year()))==null )
      {
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,' End Date on Opportunity is not in bound please contact your administrator'));
      }
       else	
       {
	       	List<API_Indexing__c>  boundDateApiNames=new  List<API_Indexing__c> ();
	       	glassSort=new set<string>();
	        metalSort=new set<string>();
	        string str='';
        	integer i=1;
        	fieldMap=new Map<String, Schema.SObjectField>();
        	fieldMap=gettingLabel('Opportunity'); 
        List<MetalMonthlyPercentage__c> metalMonthPercent=new List<MetalMonthlyPercentage__c>();
        //glassWrapperMap=gettingMapValues(boundDateApiNames,monthPercentage,'glass');
        boundDateApiNames=new List<API_Indexing__c>();
        system.debug('%%%%boundDateApiNames'+boundDateApiNames.size()); 
        boundDateApiNames = OpptyChartController.getIndexApiList(OppVar.M_Est_Start_Date__c,OppVar.Field_Completion_Date__c);
        if(boundDateApiNames.size()>24 ||boundDateApiNames.size()<0)
        {
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,' Month Difference is Greater than 24 months For Metal'));
             return;
        }
        flag=true;
        //monthPercentage=new List<MonthlyPercentage__c>();
        metalMonthPercent=[select name,Month1__c,Month2__c,Month3__c,Month4__c,Month5__c,Month6__c,Month7__c,Month8__c,Month9__c,
                        Month10__c,Month11__c,Month12__c,Month13__c,Month14__c,Month15__c,Month16__c,Month17__c,Month18__c,Month19__c,Month20__c,
                        Month21__c,Month22__c,Month23__c,Month24__c from MetalMonthlyPercentage__c where Difference__c=:boundDateApiNames.size()    ];
            
            
        str='';
        i=1;    
            for(API_Indexing__c apiIndex:boundDateApiNames)
        {
            
            str='Month'+i+'__c';
            
            metalSort.add(apiIndex.MetalApiName__c);
            //glassWrapperMap.put(apiIndex.GlassApiName__c,new config_Wrapper(fieldMap.get(apiIndex.GlassApiName__c).getDescribe().getLabel(),oppVar.Glass_Price__c,apiIndex.GlassApiName__c,(Decimal)monthPercentage[0].get(str)));
            metalWrapperMap.put(apiIndex.MetalApiName__c,new config_Wrapper(fieldMap.get(apiIndex.MetalApiName__c).getDescribe().getLabel(),oppVar.Metal_Price__c,apiIndex.MetalApiName__c,(Decimal)metalMonthPercent[0].get(str)));
            i++;
        }
	        
       }
      		
       }
       
      




 else if(oppIdentity=='Glass')
       {
       	if(Glassamount==null || Glassamount<=0)
      	{
        	ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Opportunity have no Glass amount assigned please contact your administrator '));
     	 }
     	 else if(OppVar.G_Est_Start_Date__c==null )
      		{
       			 ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Opportunity have no Start Date assigned For Glass please contact your administrator '));
      		}
      		
      	else if(oppVar.Field_Completion_Date__c<OppVar.G_Est_Start_Date__c)
      	{
        	ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,' End Date Must be Greater than or equal to start date '));
      	}
      else if (Opportunity_Year_Index__c.getInstance(string.valueof(OppVar.G_Est_Start_Date__c.year()))==null)
      {
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,' Start Date on Opportunity is not in bound please contact your administrator'));
      }
      else if (Opportunity_Year_Index__c.getInstance(string.valueof(OppVar.Field_Completion_Date__c.year()))==null )
      {
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,' End Date on Opportunity is not in bound please contact your administrator'));
      }
       else	
       {
	       	List<API_Indexing__c>  boundDateApiNames=new  List<API_Indexing__c> ();
	       	glassSort=new set<string>();
	        metalSort=new set<string>();
	        string str='';
        	integer i=1;
        	fieldMap=new Map<String, Schema.SObjectField>();
        	fieldMap=gettingLabel('Opportunity'); 
        
        //glassWrapperMap=gettingMapValues(boundDateApiNames,monthPercentage,'glass');
        boundDateApiNames=new List<API_Indexing__c>();
        system.debug('%%%%boundDateApiNames'+boundDateApiNames.size()); 
        boundDateApiNames = OpptyChartController.getIndexApiList(OppVar.G_Est_Start_Date__c,OppVar.Field_Completion_Date__c);
        if(boundDateApiNames.size()>24 ||boundDateApiNames.size()<0)
        {
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,' Month Difference is Greater than 24 months For Glass'));
             return;
        }
        flag=true;
        //monthPercentage=new List<MonthlyPercentage__c>();
     List<MonthlyPercentage__c> monthPercentage=new List<MonthlyPercentage__c>();
        monthPercentage=[select name,Month1__c,Month2__c,Month3__c,Month4__c,Month5__c,Month6__c,Month7__c,Month8__c,Month9__c,
                        Month10__c,Month11__c,Month12__c,Month13__c,Month14__c,Month15__c,Month16__c,Month17__c,Month18__c,Month19__c,Month20__c,
                        Month21__c,Month22__c,Month23__c,Month24__c from MonthlyPercentage__c where Difference__c=:boundDateApiNames.size() ];
        
                       
        for(API_Indexing__c apiIndex:boundDateApiNames)
        {
            
            str='Month'+i+'__c';
            glassSort.add(apiIndex.GlassApiName__c);
       
            glassWrapperMap.put(apiIndex.GlassApiName__c,new config_Wrapper(fieldMap.get(apiIndex.GlassApiName__c).getDescribe().getLabel(),oppVar.Glass_Price__c,apiIndex.GlassApiName__c,(Decimal)monthPercentage[0].get(str)));
            //metalWrapperMap.put(apiIndex.MetalApiName__c,new config_Wrapper(fieldMap.get(apiIndex.MetalApiName__c).getDescribe().getLabel(),oppVar.Metal_Price__c,apiIndex.MetalApiName__c,(Decimal)monthPercentage[0].get(str)));
            i++;
        }
	        
       }
      		
       }
      
        
    
    
         
} 

/*public map<string,config_Wrapper> gettingMapValues(List<API_Indexing__c>apiNameList,List<MonthlyPercentage__c> monthPercentage,string type )
{
        
        string str='';
        integer i=1;
    map<string,config_Wrapper> valueMap=new map<string,config_Wrapper>();
    for(API_Indexing__c apiIndex:apiNameList)
        {
            
            str='Month'+i+'__c';
            if(type=='glass')
            {   glassSort.add(apiIndex.GlassApiName__c);
                valueMap.put(apiIndex.GlassApiName__c,new config_Wrapper(fieldMap.get(apiIndex.GlassApiName__c).getDescribe().getLabel(),oppVar.Glass_Price__c,apiIndex.GlassApiName__c,(Decimal)monthPercentage[0].get(str)));
            }
            else
            {
                metalSort.add(apiIndex.MetalApiName__c);
                metalWrapperMap.put(apiIndex.MetalApiName__c,new config_Wrapper(fieldMap.get(apiIndex.MetalApiName__c).getDescribe().getLabel(),oppVar.Metal_Price__c,apiIndex.MetalApiName__c,(Decimal)monthPercentage[0].get(str)));
            }
            i++;
            
        }
        system.debug('++++valueMap'+valueMap);
        return valueMap;
}*/
//Wrraper class to get show label percentage and monthly amount distribution
Public class config_Wrapper
{
    public String Label{get;set;}
    public Decimal percentage{get;set;}
    public Decimal monthAmount{get;set;}

//Constructor of wrapper
public config_Wrapper( string str,decimal Price,string oppFieldName,decimal per)
{
     Label=str;
     
     
    if(Price!=null)
    monthAmount=calculatePercent(Price,per);
     percentage=per;
    
}
public decimal calculatePercent(decimal amountGM,decimal percent)
{
    return (amountGM*percent/100);
}
public config_Wrapper()
{
    Label='';
    percentage=0.0;
    monthAmount=0.0;
}

}

//method to Update opportunity with populated field values
public PageReference saveOpportunity()
{   PageReference pageRef =null;
    //PreviewPercentage();
    
    //boolean bool1=false;
    //Decimal glassAmount=0;
    //Decimal metalAmount=0;
    
    for(string apiName:glassWrapperMap.keyset())
    {
        
        
            OppVar.put(apiName, (decimal)glassWrapperMap.get(apiName).monthAmount);
            //bool1=true;
            //glassAmount+=(decimal)glassWrapperMap.get(apiName).monthAmount;
        
        
        
    }
    
    for(string apiName:metalWrapperMap.keyset())
    {
        if((decimal)metalWrapperMap.get(apiName).monthAmount==null || (decimal)metalWrapperMap.get(apiName).monthAmount==0)
        {
            
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Invalid '+fieldMap.get(apiName).getDescribe().getLabel()));
        }
        else
        {
            OppVar.put(apiName, (decimal)metalWrapperMap.get(apiName).monthAmount);
            //bool1=true;
            //metalAmount+=(decimal)metalWrapperMap.get(apiName).monthAmount;
        }
        //OppVar.put(apiName,   (decimal)metalWrapperMap.get(apiName).monthAmount);
    }
    
    
    
    //OppVar.Amount=amount;
     //oppVar.M_Est_Start_Date__c=oppVar.G_Est_Start_Date__c;
     //oppVar.M_Est_Completion_Date__c=oppVar.G_Est_Completion_Date__c;
     oppvar.id=Oli.opportunityid;
    
    try{
    update OppVar;
    //formFlag=false;
    system.debug('####'+buttonSwap+'####');
    if(buttonSwap=='true')
    {
        pageRef = new PageReference('/apex/Opportunity_Configuration_Page');
        
    }
    else
    {
        pageRef = new PageReference('/' +OppVar.id);
            
            
    }
    
    }
    catch(exception e){}
    
    
    pageRef.setRedirect(true);
    return pageRef;
    
}

Public static string identifyOpportunity( string oppId)
{
	List<opportunity> oppVar=new List<opportunity>();
	oppVar=[select id,Glass_Price__c,Metal_Price__c,Field_Completion_Date__c,G_Est_Start_Date__c,G_Est_Completion_Date__c,M_Est_Start_Date__c,M_Est_Completion_Date__c From Opportunity where id=:oppId];
	if((oppVar[0].Glass_Price__c==0 || oppVar[0].Glass_Price__c==null)  && (oppVar[0].Metal_Price__c<>0 && oppVar[0].Metal_Price__c<>null))
	{
		return 'Metal';
	}
	
	else if((oppVar[0].Glass_Price__c<>0 && oppVar[0].Glass_Price__c<>null)&& (oppVar[0].Metal_Price__c==0 || oppVar[0].Metal_Price__c==null))
	{
		return 'Glass';
	}
	
	else
	{
		return 'Both';
	}
}

}