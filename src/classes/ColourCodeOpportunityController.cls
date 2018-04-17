global with sharing class ColourCodeOpportunityController {
public List<Opportunity> opportunityList{get;set;}
public  map<string,string> colourMap;
//public map<string,jsonWrapper> opportunityWithColour{get;set;}
//public List<jsonWrapper> oppData{get;set;} 
public String jsonData{get;set;}
public String jsonDataForCB{get;set;}
public String jsonDataForQ3AW{get;set;}
public String jsonDataForQ3BeAW{get;set;}

Public List<string>monthName; 
Public string filter{get;set;} 

//List to show the limited records on the page
public List<opportunity> opportunitiesToShow{get;set;}

//Navigation variables
Integer counter = 0;  //TO track the number of records parsed
Integer limitSize = Integer.valueof(label.LimtColourCode.trim());//Number of records to be displayed
Integer totalSize =0; //To Store the total number of records available 

   public ColourCodeOpportunityController()
   {
     filter='';
    opportunityList = new List<Opportunity>();
    opportunityList=[select id,name, G_Est_Start_Date__c,M_Est_Start_Date__c,Field_Completion_Date__c, Account.Name,StageName,Contract_Amount__c,Opportunity_State__c,CloseDate from Opportunity Where Field_Completion_Date__c !=null AND (G_Est_Start_Date__c !=null OR M_Est_Start_Date__c !=null) Limit 1000 ];
    system.debug('@@@@@@ ColourCodeOpportunityController ::'+opportunityList);
     pagination(opportunityList);
     monthName=new List<string>{'Jan','Feb','Mar','April','May','June','July','Aug','Sep','Oct','Nov','Dec'};
     colourMap=new  map<string,string>();
     colourMap.put('AZ','#008000');
     colourMap.put('TX','#FFA500');
     colourMap.put('CA','#0000FF');
     colourMap.put('TN','#FF0000');
     
       
       
       
        jsondata='';
        jsonDataForCB = '';
        jsonDataForQ3AW = '';
        jsonDataForQ3BeAW = '';
       //opportunityWithColour=fillColour(opportunityList);
      
       getJsonVal();
       
       
   }
Public void pagination( List<opportunity> tempOppList)
{
	 system.debug('@@@@@@ List<opportunity> tempOppList ::'+tempOppList);
     opportunitiesToShow = new list<opportunity>();
     counter = 0;
     totalSize =0;
     //opportunityList = new List<Opportunity>();
     //opportunityList=[select id,name, G_Est_Start_Date__c,Field_Completion_Date__c, Account.Name,StageName,Opportunity_State__c from Opportunity Limit 100 ];
     totalSize = tempOppList.size();
     system.debug('@@@@@@ totalSize ::'+totalSize);
     
     if(totalSize<>0)
      {
      	system.debug('@@@@@@ counter ::'+counter);
      	system.debug('@@@@@@ limitSize ::'+limitSize);
      	
        if((counter+limitSize) <= totalSize){
            for(Integer i=0;i<limitSize;i++){
                opportunitiesToShow.add(opportunityList.get(i));
            }
            system.debug('@@@@@@ opportunitiesToShow IF::'+opportunitiesToShow);
        }else{
            for(Integer i=0;i<totalSize;i++){
                opportunitiesToShow.add(opportunityList.get(i));
            }
            system.debug('@@@@@@ opportunitiesToShow ELSE ::'+opportunitiesToShow);
        }
      }
      else 
      {
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Info,' No Opportunities to Show '));
      }
}
Public void getFilterOpportunity()
{
    string state;
    state=filter;
    opportunityList=new List<opportunity>();
    if(state=='None')
    {
        
        opportunityList=[select id,name, G_Est_Start_Date__c,M_Est_Start_Date__c,Field_Completion_Date__c, Account.Name,StageName,Opportunity_State__c,Contract_Amount__c,CloseDate from Opportunity where Opportunity_State__c NOT In : colourMap.keySet() AND Field_Completion_Date__c !=null AND (G_Est_Start_Date__c !=null OR M_Est_Start_Date__c !=null) Limit 1000 ];
    	system.debug('@@@@@@ getFilterOpportunity opportunityList None IF ::'+opportunityList);
    }
    else if(state=='All')
    {
        opportunityList=[select id,name, G_Est_Start_Date__c,M_Est_Start_Date__c,Field_Completion_Date__c, Account.Name,StageName,Opportunity_State__c,Contract_Amount__c,CloseDate from Opportunity Where Field_Completion_Date__c !=null AND (G_Est_Start_Date__c !=null OR M_Est_Start_Date__c !=null) Limit 1000 ];
    	system.debug('@@@@@@ getFilterOpportunity opportunityList All ELSE IF ::'+opportunityList);
    }
    
    else
    {
        opportunityList=[select id,name, G_Est_Start_Date__c,M_Est_Start_Date__c,Field_Completion_Date__c, Account.Name,StageName,Opportunity_State__c,Contract_Amount__c,CloseDate from Opportunity where Opportunity_State__c =: state AND Field_Completion_Date__c !=null AND (G_Est_Start_Date__c !=null OR M_Est_Start_Date__c !=null) Limit 1000 ];
    	system.debug('@@@@@@ getFilterOpportunity opportunityList ELSE ::'+opportunityList);
    }
    pagination(opportunityList);
    getJsonVal();
}

Public void getJsonVal()
{
    JsonParser jsonObject=new JsonParser();
       jsonObject=getJsonObjectVal();
       
       
       jsondata=JSON.serialize(jsonObject);
       jsondata=jsondata.replace('enddate','end');
       system.debug('::::jsondata'+jsondata);
}   
Public  JsonParser getJsonObjectVal()
{
    JsonParser jsonObject=new JsonParser();
    JsonParser jsonObjectCB =new JsonParser();
    JsonParser jsonObjectQ3AW =new JsonParser();
    JsonParser jsonObjectQ3BeAW =new JsonParser();
    List<Opportunity> oppList=new List<Opportunity>();   
    List<Opportunity> oppListCB=new List<Opportunity>();  
    List<Opportunity> oppListQ3AW=new List<Opportunity>();  
    List<Opportunity> oppListQ3BeAW=new List<Opportunity>();
    
    String DateInCS = Label.CurrentYear;
    String[] myDateOnly = DateInCS.split(' ');
    String[] strDate = myDateOnly[0].split('/');
    Integer myIntMonth = integer.valueOf(strDate[0]);
    Integer myIntDate = integer.valueOf(strDate[1]);
    Integer myIntYear = integer.valueOf(strDate[2]);
    //Close date – July 1, 2017 – Spetember 30, 2017 
    Date CloseDateForQ3 = Date.newInstance(myIntYear, 07, 01);
    Date CloseDateForQ31 = Date.newInstance(myIntYear, 09, 30);
    
     //oppList=[select id,name, G_Est_Start_Date__c,M_Est_Start_Date__c,Field_Completion_Date__c, Account.Name,StageName,Opportunity_State__c from Opportunity  where G_Est_Start_Date__c!=null AND Field_Completion_Date__c!=null limit 100 ];
       oppList=opportunitiesToShow;
       for(Opportunity opp: oppList){
       system.debug('@@@@@@'+opp);
        if(opp.StageName =='Fully Executed Contract'||  opp.StageName =='Contract In Process' ||  opp.StageName =='LOI'){
            Date StartDate = getCloserDate(opp.G_Est_Start_Date__c,opp.M_Est_Start_Date__c);
            system.debug('####'+opp.Field_Completion_Date__c.Year());
            system.debug('####!!!!'+myIntYear);
            if(opp.Field_Completion_Date__c.Year()== myIntYear){               
                if(StartDate < System.today()){
                    oppListCB.add(opp);
                }   
            }
            if((CloseDateForQ3 < opp.Field_Completion_Date__c) && (opp.Field_Completion_Date__c < CloseDateForQ31)){
                if(StartDate > System.today()){
                        oppListQ3AW.add(opp);
                    } 
                
            }
            
        }else{
            if(opp.StageName =='Active'||  opp.StageName =='Closing' ||  opp.StageName =='Verbal Commit'){
                if((CloseDateForQ3 < opp.Field_Completion_Date__c) && (opp.Field_Completion_Date__c < CloseDateForQ31)){
                    oppListQ3BeAW.add(opp);
                }
            }
        }
       }
       
       //Populating the 
       System.debug('@@@@@oppListCB'+oppListCB);
       // Json For jsonObjectCB
       jsonObjectCB = getprocessesAndTasksValues(jsonObjectCB,oppListCB);
       jsonDataForCB=JSON.serialize(jsonObjectCB);
       jsonDataForCB=jsonDataForCB.replace('enddate','end');
       System.debug('@@@@@jsonDataForCB'+jsonDataForCB);
       // Json For jsonObjectQ3AW
       jsonObjectQ3AW = getprocessesAndTasksValues(jsonObjectQ3AW,oppListQ3AW);
       jsonDataForQ3AW=JSON.serialize(jsonObjectQ3AW);
       jsonDataForQ3AW=jsonDataForQ3AW.replace('enddate','end');
       
       // Json For jsonObjectQ3BeAW
       jsonObjectQ3BeAW = getprocessesAndTasksValues(jsonObjectQ3BeAW,oppListQ3BeAW);
       jsonDataForQ3BeAW=JSON.serialize(jsonObjectQ3BeAW);
       jsonDataForQ3BeAW=jsonDataForQ3BeAW.replace('enddate','end');
       
       jsonObject=getprocessesAndTasksValues(jsonObject,oppList);
       return jsonObject;
}   
   
Public JsonParser.chart getChartValues(JsonParser.chart chartVar)
{
    //chartVar.caption='Opportunity Analysis';
    //chartVar.subcaption='Gantt Chart';
   // chartVar.dateformat='yyyy-mm-dd';
   	  chartVar.useVerticalScrolling='0';
    return chartVar;
}

public List<JsonParser.categories> getCategoriesValues(List<JsonParser.categories> categoriesVar )
{
    JsonParser.categories categVar=new JsonParser.categories();
    categVar.category=new List<JsonParser.category>();
    categVar.category=getCategoryList(categVar.category); 
    categoriesVar.add(categVar);
    return categoriesVar;
}

public List<JsonParser.category> getCategoryList(List<JsonParser.category> categoryList)
{
    
    String cusLabel = Label.EvaluationDate;
    date strtDate = date.parse(cusLabel);
    strtDate=strtDate.toStartOfMonth();
    
    for(integer i=0;i<48;i++)
    {
        
            categoryList.add(getCategoryVal(strtDate));
            strtDate=strtDate.addMonths(1);
    }
    return categoryList;
}

Public JsonParser.category getCategoryVal(date stDate)
{
    JsonParser.category categVar=new JsonParser.category();
    categVar.start=string.valueof(stDate);
    Integer numberOfDays = Date.daysInMonth(stDate.year(), stDate.month());
    Date lastDayOfMonth = Date.newInstance(stDate.year(), stDate.month(), numberOfDays);
    categVar.endDate=string.valueof(lastDayOfMonth);
    categVar.label=monthName[lastDayOfMonth.month()-1]+string.valueof(lastDayOfMonth.year()).right(2);
    categVar.align='middle'; 
    return categVar; 
}

public JsonParser getprocessesAndTasksValues(JsonParser jsonObject,List<opportunity>oppList)
{
    //Populating the chart values for json
       jsonObject.chart=new JsonParser.chart();
       jsonObject.chart=getChartValues(jsonObject.chart);
       
       //Populating the categories for json
       jsonObject.categories=new List<JsonParser.categories>();
       jsonObject.categories=getCategoriesValues(jsonObject.categories);
     
       
    
    JsonParser.processes processesVar=new JsonParser.processes();
    processesVar.process=new List<JsonParser.process>();
    
    JsonParser.tasks tasksVar=new JsonParser.tasks();
    tasksVar.task=new List<JsonParser.task>();
    
    JsonParser.datatable datatableVar=new JsonParser.datatable();
    datatableVar.datacolumn=new List< JsonParser.datacolumn>();
    
    JsonParser.datacolumn dataColumnVar=new JsonParser.datacolumn();
    dataColumnVar.text=new List<JsonParser.text>();
    dataColumnVar.headertext='Amount';
    
    JsonParser.datacolumn dataColumnVarAcc=new JsonParser.datacolumn();
    dataColumnVarAcc.text=new List<JsonParser.text>();
    dataColumnVarAcc.headertext='Account Name';
    
    for(opportunity opp:oppList)
    {
        processesVar.process.add( getProcess(opp));
        tasksVar.task.add(getTask(opp));
        dataColumnVar.text.add(getText(opp,'amount'));
        dataColumnVarAcc.text.add(getText(opp,'account'));
        
    }
    jsonObject.processes=processesVar;
    jsonObject.tasks=tasksVar;
    datatableVar.datacolumn.add(dataColumnVar);
    datatableVar.datacolumn.add(dataColumnVarAcc);
    jsonObject.datatable=datatableVar;
    
    return jsonObject; 
}

public JsonParser.text getText(opportunity opp , string Column)
{
    JsonParser.text textVar=new JsonParser.text();
    if(Column=='amount')
    textVar.label= '$' + string.valueof(opp.Contract_Amount__c);
    else 
    textVar.label=opp.Account.Name;
    
    return textVar;
}
public JsonParser.process getProcess(opportunity opp)
{
    JsonParser.process processVar=new JsonParser.process();
    processVar.label=opp.Name;
    processVar.id=opp.id;
    return processVar;
    
}

public JsonParser.task getTask(opportunity opp)
{
    
    JsonParser.task taskVar=new JsonParser.task();
    taskVar.enddate=string.valueof(opp.Field_Completion_Date__c);
    taskVar.start=string.valueof(getCloserDate(opp.G_Est_Start_Date__c,opp.M_Est_Start_Date__c));
    if(colourMap.containsKey(opp.Opportunity_State__c))
    taskVar.color=colourMap.get(opp.Opportunity_State__c);
    else
    taskVar.color='#800080';
    return taskVar;
    
}

Public date getCloserDate(date d1,date d2)
{
    if(d1 !=null && d2 != null){
        if(d1>d2)
        {
            return d2;
        
        }
        else
        return d1;
    }else{
        if(d1==null && d2 !=null){
            return d2;
        }else{
            return d1;
        }
    }
    
    
}


public void beginning(){
   
        opportunitiesToShow.clear();
        counter=0;
        system.debug('@@@@@@ beginning counter ::'+counter);
        system.debug('@@@@@@ beginning limitSize ::'+limitSize);
        system.debug('@@@@@@ beginning totalSize ::'+totalSize);
        
        if((counter + limitSize) <= totalSize){
       
            for(Integer i=0;i<limitSize;i++){
                opportunitiesToShow.add(opportunityList.get(i));
            }   
            system.debug('@@@@@@ beginning opportunitiesToShow IF ::'+opportunitiesToShow);
            
        } else{
       
            for(Integer i=0;i<totalSize;i++){
                opportunitiesToShow.add(opportunityList.get(i));
            }       
            system.debug('@@@@@@ beginning opportunitiesToShow ELSE ::'+opportunitiesToShow);
        }
        getJsonVal();
    
    }
   
    public void next(){
   
        opportunitiesToShow.clear();
        system.debug('@@@@@@ next counter ::'+counter);
        counter=counter+limitSize;
        system.debug('@@@@@@ next counter=counter+limitSize ::'+counter);
       
        if((counter+limitSize) <= totalSize){
            for(Integer i=counter;i<(counter+limitSize);i++){
                opportunitiesToShow.add(opportunityList.get(i));
            }
            system.debug('@@@@@@ next opportunitiesToShow IF ::'+opportunitiesToShow);
        } else{
            for(Integer i=counter;i<totalSize;i++){
                opportunitiesToShow.add(opportunityList.get(i));
            }
            system.debug('@@@@@@ next opportunitiesToShow ELSE ::'+opportunitiesToShow);
        }
     getJsonVal();
    }
   
    public void previous(){
   
        opportunitiesToShow.clear();
		system.debug('@@@@@@ previous counter ::'+counter);
        counter=counter-limitSize;
        system.debug('@@@@@@ previous counter=counter-limitSize ::'+counter);      
       
        for(Integer i=counter;i<(counter+limitSize); i++){
            opportunitiesToShow.add(opportunityList.get(i));
        }
        system.debug('@@@@@@ previous opportunitiesToShow  ::'+opportunitiesToShow);
        getJsonVal();
    }

    public void last(){
   
        opportunitiesToShow.clear();
        system.debug('@@@@@@ last totalSize ::'+totalSize);
        system.debug('@@@@@@ last limitSize ::'+limitSize);
        system.debug('@@@@@@ last math.mod(totalSize , limitSize) ::'+math.mod(totalSize , limitSize));
        
        if(math.mod(totalSize , limitSize) == 0){
            counter = limitSize * ((totalSize/limitSize)-1);
            system.debug('@@@@@@ last counter IF::'+counter);
        } else if (math.mod(totalSize , limitSize) != 0){
            counter = limitSize * ((totalSize/limitSize));
            system.debug('@@@@@@ last counter ELSE IF::'+counter);
        }
       
        for(Integer i=counter;i<totalSize;i++){
                opportunitiesToShow.add(opportunityList.get(i));
        }
        system.debug('@@@@@@ last opportunitiesToShow  ::'+opportunitiesToShow);
        getJsonVal();
    }
   
    public Boolean getDisableNext(){
   
   		system.debug('@@@@@@ getDisableNext counter ::'+counter);
   		system.debug('@@@@@@ getDisableNext limitSize ::'+limitSize);
   		system.debug('@@@@@@ getDisableNext totalSize ::'+totalSize);
   		
        if((counter + limitSize) >= totalSize  ){
        	system.debug('@@@@@@ getDisableNext IF ::');
            return true ;
        }
        else{
        	system.debug('@@@@@@ getDisableNext ELSE ::');
            return false ;
        }
    }
    
    public Boolean getDisablePrevious(){
   
        if(counter ==0 ){
        	system.debug('@@@@@@ getDisablePrevious IF ::');
            return true ;
        }
        else{
        	system.debug('@@@@@@ getDisablePrevious ELSE ::');
            return false ;
        }
    } 
    
}