public class OpptyChartController {
    
    public boolean bool{get;set;}
    ApexPages.StandardController oppController;
    
    public static Opportunity oppObj {get; set;}
    public static Date gStartDate {get;set;}
    public static Date gEndDate {get;set;}
    public static Date mStartDate {get;set;}
    public static Date mEndDate {get;set;}
    public static Decimal glassPrice {get;set;}
    public static Decimal metalPrice {get;set;}
    private Opportunity opp;
    
    public OpptyChartController(ApexPages.StandardController controller){
        bool=false;
        oppObj = (Opportunity) controller.getRecord();
        opp = [SELECT G_Est_Start_Date__c,M_Est_Start_Date__c,Field_Completion_Date__c, Glass_Price__c,Metal_Price__c From Opportunity Where Id = :oppObj.Id];
        gStartDate = opp.G_Est_Start_Date__c;
        gEndDate = opp.Field_Completion_Date__c;
        mStartDate = opp.M_Est_Start_Date__c;
        mEndDate = opp.Field_Completion_Date__c;
        glassPrice = opp.Glass_Price__c;
        metalPrice = opp.Metal_Price__c;
        
    }
    public List<glassWrapper> getGlassData(){
        String oppType = Configuration_Page_Controller.identifyOpportunity(oppObj.Id);
        if(oppType == 'Glass' || oppType == 'Both'){
            if(glassPrice == null || glassPrice <= 0 || gStartDate == null || gEndDate == null){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'No Data Found For Glass Distribution'));
                return null;
            }
            else {
                List<glassWrapper> glassData = new List<glassWrapper>();
                Opportunity glassOpp;
                Set<String> glassSet = new Set<String>();
                
                List<API_Indexing__c> glassIndexList =new List<API_Indexing__c>();
                Map<String,Decimal> glassValuesMap = new Map<String,Decimal>(); 
                
                //Method Call to retrieve Index Values for Glass Fields API Names
                
                glassIndexList = OpptyChartController.getIndexApiList(gStartDate,gEndDate);
                
                String glassFields = '';
                Map<String, Schema.SObjectField> fieldMap = Schema.getGlobalDescribe().get('Opportunity').getDescribe().fields.getMap();
                for(String fieldName : fieldMap.keyset()){
                    for(API_Indexing__c apiFields : glassIndexList){
                        if(fieldName == apiFields.GlassApiName__c){
                            if(glassFields == null || glassFields == ''){
                                glassFields = fieldName;
                            }
                            else{
                                glassFields = glassFields + ', ' + fieldName;
                            }
                        }
                    }
                }
                
                String glassQuery = 'Select Id, ' + glassFields + ' From Opportunity ' + ' Where Id = \'' + oppObj.Id + '\' ';
                glassOpp = Database.query(glassQuery);
                if(!glassIndexList.isEmpty() && glassIndexList != null){
                    for(API_Indexing__c api : glassIndexList){
                        glassSet.add(api.Name);
                        glassValuesMap.put(api.Name, (Decimal) glassOpp.get(api.GlassApiName__c));
                    }
                }
                if(!glassSet.isEmpty() && glassSet != null){  
                    for(String s : glassSet){
                        if(glassValuesMap.get(s) != null){
                            glassData.add(new glassWrapper(s,'$' + String.valueOf(glassValuesMap.get(s))));
                        }                
                    }
                }
                if(!glassData.isEmpty() && glassData != null){
                    return glassData;
                }
                else{
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'No Data Found For Glass Distribution'));
                    return null;
                }
            }  
        }
        else{
            return null;
        }    
    }
    
    public List<metalWrapper> getMetalData(){
        String oppType = Configuration_Page_Controller.identifyOpportunity(oppObj.Id);
        if(oppType == 'Metal' || oppType == 'Both'){
            if(metalPrice == null || metalPrice <= 0 || mStartDate == null || mEndDate == null){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'No Data Found for Metal Distribution'));
                return null;
            }
            else {
                List<metalWrapper> metalData = new List<metalWrapper>();
                Opportunity metalOpp;
                Set<String> metalSet = new Set<String>();
                Map<String,Decimal> metalValuesMap = new Map<String,Decimal>();
                List<API_Indexing__c> metalIndexList =new List<API_Indexing__c>();
                
                //Method Call to retrieve Index Values for Glass Fields API Names
                
                metalIndexList = OpptyChartController.getIndexApiList(mStartDate,mEndDate);
                
                String metalFields = '';
                Map<String, Schema.SObjectField> fieldMap = Schema.getGlobalDescribe().get('Opportunity').getDescribe().fields.getMap();
                for(String fieldName : fieldMap.keyset()){
                    for(API_Indexing__c apiFields : metalIndexList){
                        if(fieldName == apiFields.MetalApiName__c){
                            if(metalFields == null || metalFields == ''){
                                metalFields = fieldName;
                            }
                            else{
                                metalFields = metalFields + ', ' + fieldName;
                            }
                        }
                    }
                }
                
                String metalQuery = 'Select Id, ' + metalFields + ' From Opportunity ' + ' Where Id = \'' + oppObj.Id + '\' ';
                metalOpp = Database.query(metalQuery);
                
                if(!metalIndexList.isEmpty() && metalIndexList != null){
                    for(API_Indexing__c api : metalIndexList){
                        metalSet.add(api.Name);
                        metalValuesMap.put(api.Name, (Decimal) metalOpp.get(api.MetalApiName__c));
                    }
                }
                if(!metalSet.isEmpty() && metalSet != null){  
                    for(String s : metalSet){
                        if(metalValuesMap.get(s) != null){
                            metalData.add(new metalWrapper(s,'$' + String.valueOf(metalValuesMap.get(s))));
                        }               
                    }
                }
                if(!metalData.isEmpty() && metalData != null){
                    return metalData;
                }
                else{
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'No Data Found For Metal Distribution'));
                    return null;
                }
            }
        }
        else{
            return null;
        }
    }
    
    public static List<API_Indexing__c> getIndexApiList(Date sDate, Date eDate){
        Integer startMonth, endMonth, startYear, endYear;
        Opportunity_Year_Index__c startYearIndex=new Opportunity_Year_Index__c() ;
        Opportunity_Year_Index__c endYearIndex=new Opportunity_Year_Index__c();
        Integer startIndexVal=0; 
        integer endIndexVal=0;
        startYear = sDate.year();
        endYear = eDate.year();
        startMonth = sDate.month();
        endMonth = eDate.month();
        
        if(Opportunity_Year_Index__c.getinstance(String.valueOf(startYear))!=null){ 
            startYearIndex = Opportunity_Year_Index__c.getValues(String.valueOf(startYear));
            startIndexVal = Integer.valueOf(startYearIndex.startIndex__c) + startMonth -1;
        }
        
        if(Opportunity_Year_Index__c.getInstance(String.valueOf(endYear))!=null){
            endYearIndex = Opportunity_Year_Index__c.getValues(String.valueOf(endYear));
            endIndexVal = Integer.valueOf(endYearIndex.startIndex__c) + endMonth - 1;
        }
        
        List<API_Indexing__c> apiIndexList = [Select Name, GlassApiName__c, MetalApiName__c FROM API_Indexing__c
                                              WHERE API_Index_Value__c >= :startIndexVal AND API_Index_Value__c <= :endIndexVal
                                              ORDER BY API_Index_Value__c];
        
        if(!apiIndexList.isEmpty() && apiIndexList != null){
            return apiIndexList;
        }
        else{
            return null;
        }
    }
    
    //Glass Wrapper Class 
    public class glassWrapper{
        public String glassMonth {get;set;}
        public String glassValue {get;set;}
        
        public glassWrapper(String glassMonth,String glassValue){
            this.glassMonth = glassMonth;
            this.glassValue = glassValue;
        }
    }
    
    //Metal Wrapper Class
    public class metalWrapper{
        public String metalMonth {get;set;}
        public String metalValue {get;set;}
        
        public metalWrapper(String metalMonth,String metalValue){
            this.metalMonth = metalMonth;
            this.metalValue = metalValue;
        }
    }
}