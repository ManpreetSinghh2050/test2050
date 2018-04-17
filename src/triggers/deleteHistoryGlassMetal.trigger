trigger deleteHistoryGlassMetal on Opportunity(after insert,before update){
public List<Lost_metal_glass__c> metalglassList = new List<Lost_metal_glass__c>();
  if (Trigger.isAfter) {
    if(Trigger.isInsert){

      List<Opportunity> oppListforGlass = new List<Opportunity>();
        List<Opportunity> oppListforMetal = new List<Opportunity>();
      for(Opportunity oppInst : Trigger.new){
        if(oppInst.Glass_Lost__c == true ){
            Lost_metal_glass__c lmgInst = new Lost_metal_glass__c();
            
            lmgInst.Glass_Price__c = oppInst.Glass_Price__c;
            lmgInst.G_Est_Start_Date__c =oppInst.G_Est_Start_Date__c;
            lmgInst.G_Est_Completion_Date__c =oppInst.G_Est_Completion_Date__c;
            lmgInst.G_Est_Man_Hours_Field__c = oppInst.G_Est_Man_Hours_Field__c;
            lmgInst.G_Est_Man_Hours_Shop__c = oppInst.G_Est_Man_Hours_Shop__c;
            lmgInst.G_Crew_Size__c = oppInst.G_Crew_Size__c;
            lmgInst.Material_Cost__c = oppInst.Material_Cost__c;
            lmgInst.Shop_Labor_Cost__c = oppInst.Shop_Labor_Cost__c;
            lmgInst.Field_Labor_Costs__c = oppInst.Field_Labor_Costs__c;
            lmgInst.Glass_GPM__c = oppInst.Glass_GPM__c;
            lmgInst.Opportunity__c = oppInst.Id;
            lmgInst.Name = 'Glass Lost';
            system.debug('>>>'+lmgInst);
            metalglassList.add(lmgInst);
                
            Opportunity oppTO = new Opportunity();  
             
            oppTO.Glass_Price__c = null;
            oppTO.G_Est_Start_Date__c = null;
            oppTO.G_Est_Completion_Date__c =null;
            oppTO.G_Est_Man_Hours_Field__c = null;
            oppTO.G_Est_Man_Hours_Shop__c = null;
            oppTO.G_Crew_Size__c = null;
            oppTO.Material_Cost__c = null;
            oppTO.Shop_Labor_Cost__c = null;
            oppTO.Field_Labor_Costs__c = null;
            oppTO.Glass_GPM__c = null;        
            oppTo.Id = oppInst.Id;

            oppListforGlass.add(oppTo);
            
            TriggerStopper.stopOpp = true;
     }
          
     if(oppInst.Metal_Lost__c == true){
         Lost_metal_glass__c lmgInst = new Lost_metal_glass__c();
         
            lmgInst.Metal_Price__c = oppInst.Metal_Price__c;
            lmgInst.M_Est_Start_Date__c =oppInst.M_Est_Start_Date__c;
            lmgInst.M_Est_Completion_Date__c =oppInst.M_Est_Completion_Date__c;
            lmgInst.M_Est_Man_Hours_Field__c = oppInst.M_Est_Man_Hours_Field__c;
            lmgInst.M_Est_Man_Hours_Shop__c = oppInst.M_Est_Man_Hours_Shop__c;
            lmgInst.M_Crew_Size__c = oppInst.M_Crew_Size__c;
            lmgInst.M_Material_Cost__c = oppInst.M_Material_Cost__c;
            lmgInst.M_Shop_Labor_Cost__c = oppInst.M_Shop_Labor_Cost__c;
            lmgInst.M_Field_Labor_Cost__c = oppInst.M_Field_Labor_Cost__c;
            lmgInst.Metal_GPM__c = oppInst.Metal_GPM__c;
            lmgInst.Opportunity__c = oppInst.Id;
            lmgInst.Name = 'Metal Lost';
            system.debug('>>>'+lmgInst);
            metalglassList.add(lmgInst);
         
          Opportunity oppTO = new Opportunity();  
             
            oppTO.Metal_Price__c = null;
            oppTO.M_Est_Start_Date__c = null;
            oppTO.M_Est_Completion_Date__c =null;
            oppTO.M_Est_Man_Hours_Field__c = null;
            oppTO.M_Est_Man_Hours_Shop__c = null;
            oppTO.M_Crew_Size__c = null;
            oppTO.M_Material_Cost__c = null;
            oppTO.M_Shop_Labor_Cost__c = null;
            oppTO.M_Field_Labor_Cost__c = null;
            oppTO.Metal_GPM__c = null;        
            oppTo.Id = oppInst.Id;

            oppListforMetal.add(oppTo);
            
            TriggerStopper.stopOpp = true;

     }
    }
   try{
    Database.insert(metalglassList);
    Database.update(oppListforGlass);
    Database.update(oppListforMetal);
    }catch(Exception e){
        System.debug('In Catch Error'+e);
        } 
      }
    }
    
    if(Trigger.isBefore && Trigger.isUpdate){
        TriggerStopper.stopOpp = false;
        OpportunityTriggerHandler.setLostGlass(Trigger.New, Trigger.oldMap);
        OpportunityTriggerHandler.setLostMetal(Trigger.New, Trigger.oldMap);
    }
}