public class OpportunityTriggerHandler {
    
    public static void setLostGlass(List<Opportunity> newOppList, Map<Id,Opportunity> oldOppMap){
        
        List<Lost_metal_glass__c> lmgList = new List<Lost_metal_glass__c>();
        Map<Id,Opportunity> lostOpptyMap = new Map<Id,Opportunity>();
        
        for(Opportunity opp : newOppList){
            if(opp.Glass_Lost__c == true && oldOppMap.get(opp.Id).Glass_Lost__c == false){
                if(TriggerStopper.stopOpp == false){
                    Lost_metal_glass__c lmgObj = new Lost_metal_glass__c();
                    lmgObj.Name = 'Glass Lost';
                    lmgObj.Glass_Price__c = opp.Glass_Price__c;
                    lmgObj.G_Est_Start_Date__c = opp.G_Est_Start_Date__c;
                    lmgObj.G_Est_Completion_Date__c = opp.G_Est_Completion_Date__c;
                    lmgObj.G_Est_Man_Hours_Shop__c = opp.G_Est_Man_Hours_Shop__c;
                    lmgObj.G_Est_Man_Hours_Field__c = opp.G_Est_Man_Hours_Field__c;
                    lmgObj.G_Crew_Size__c = opp.G_Crew_Size__c;
                    lmgObj.Material_Cost__c = opp.Material_Cost__c;
                    lmgObj.Shop_Labor_Cost__c = opp.Shop_Labor_Cost__c;
                    lmgObj.Field_Labor_Costs__c = opp.Field_Labor_Costs__c;
                    lmgObj.Glass_GPM__c = opp.Glass_GPM__c;
                    lmgObj.Glass_Estimator__c = opp.Test_Estimator_Field__c;
                    lmgObj.Opportunity__c = opp.Id;
                    lmgList.add(lmgObj);
                    
                    opp.Glass_Price__c = null;
                    opp.G_Est_Start_Date__c = null;
                    opp.G_Est_Completion_Date__c = null;
                    opp.G_Est_Man_Hours_Shop__c = null;
                    opp.G_Est_Man_Hours_Field__c = null;
                    opp.G_Crew_Size__c = null;
                    opp.Material_Cost__c = null;
                    opp.Shop_Labor_Cost__c = null;
                    opp.Field_Labor_Costs__c = null;
                    opp.Glass_GPM__c = null;
                    //opp.Test_Estimator_Field__c = null;
                }
            }
            else if(opp.Glass_Lost__c == false && oldOppMap.get(opp.Id).Glass_Lost__c == true){
                if(TriggerStopper.stopOpp == false){
                    lostOpptyMap.put(opp.Id,opp);   
                }
            }
        }
        
        List<Lost_metal_glass__c> lostMGList = [Select Name,Glass_Price__c,G_Est_Start_Date__c,G_Est_Completion_Date__c,G_Est_Man_Hours_Shop__c,G_Est_Man_Hours_Field__c,G_Crew_Size__c,
                                               Material_Cost__c,Shop_Labor_Cost__c,Field_Labor_Costs__c,Glass_GPM__c,Opportunity__c,Glass_Estimator__c From Lost_metal_glass__c 
                                               Where Opportunity__c IN :lostOpptyMap.keyset()];
        
        for(Lost_metal_glass__c lmgObj : lostMGList){
            for(Id oppId : lostOpptyMap.keyset()){
                if(oppId == lmgObj.Opportunity__c){
                    lostOpptyMap.get(oppId).Glass_Price__c = lmgObj.Glass_Price__c;
                    lostOpptyMap.get(oppId).G_Est_Start_Date__c = lmgObj.G_Est_Start_Date__c;
                    lostOpptyMap.get(oppId).G_Est_Completion_Date__c = lmgObj.G_Est_Completion_Date__c;
                    lostOpptyMap.get(oppId).G_Est_Man_Hours_Shop__c = lmgObj.G_Est_Man_Hours_Shop__c;
                    lostOpptyMap.get(oppId).G_Est_Man_Hours_Field__c = lmgObj.G_Est_Man_Hours_Field__c;
                    lostOpptyMap.get(oppId).G_Crew_Size__c = lmgObj.G_Crew_Size__c;
                    lostOpptyMap.get(oppId).Material_Cost__c = lmgObj.Material_Cost__c;
                    lostOpptyMap.get(oppId).Shop_Labor_Cost__c = lmgObj.Shop_Labor_Cost__c;
                    lostOpptyMap.get(oppId).Field_Labor_Costs__c = lmgObj.Field_Labor_Costs__c;
                    lostOpptyMap.get(oppId).Glass_GPM__c = lmgObj.Glass_GPM__c;
                    //lostOpptyMap.get(oppId).Test_Estimator_Field__c = lmgObj.Glass_Estimator__c;
                    
                    /*lmgObj.Glass_Price__c = null;
                    lmgObj.G_Est_Start_Date__c = null;
                    lmgObj.G_Est_Completion_Date__c = null;
                    lmgObj.G_Est_Man_Hours_Shop__c = null;
                    lmgObj.G_Est_Man_Hours_Field__c = null;
                    lmgObj.G_Crew_Size__c = null;
                    lmgObj.Material_Cost__c = null;
                    lmgObj.Shop_Labor_Cost__c = null;
                    lmgObj.Field_Labor_Costs__c = null;
                    lmgObj.Glass_GPM__c = null;
                    lmgList.add(lmgObj); */
                }
            }
        }
        if(!lmgList.isEmpty()){
            Database.upsert(lmgList,false);
        }
    }
    
    public static void setLostMetal(List<Opportunity> newOppList, Map<Id,Opportunity> oldOppMap){
        
        List<Lost_metal_glass__c> lmgList = new List<Lost_metal_glass__c>();
        Map<Id,Opportunity> lostOpptyMap = new Map<Id,Opportunity>();
        
        for(Opportunity opp : newOppList){
            if(opp.Metal_Lost__c == true && oldOppMap.get(opp.Id).Metal_Lost__c == false){
                if(TriggerStopper.stopOpp == false){
                    Lost_metal_glass__c lmgObj = new Lost_metal_glass__c();
                    lmgObj.Name = 'Metal Lost';
                    lmgObj.Metal_Price__c = opp.Metal_Price__c;
                    lmgObj.M_Est_Start_Date__c = opp.M_Est_Start_Date__c;
                    lmgObj.M_Est_Completion_Date__c = opp.M_Est_Completion_Date__c;
                    lmgObj.M_Est_Man_Hours_Shop__c = opp.M_Est_Man_Hours_Shop__c;
                    lmgObj.M_Est_Man_Hours_Field__c = opp.M_Est_Man_Hours_Field__c;
                    lmgObj.M_Crew_Size__c = opp.M_Crew_Size__c;
                    lmgObj.M_Material_Cost__c = opp.M_Material_Cost__c;
                    lmgObj.M_Shop_Labor_Cost__c = opp.M_Shop_Labor_Cost__c;
                    lmgObj.M_Field_Labor_Cost__c = opp.M_Field_Labor_Cost__c;
                    lmgObj.Metal_GPM__c = opp.Metal_GPM__c;
                    lmgObj.Opportunity__c = opp.Id;
                    lmgObj.Metal_Estimator__c = opp.Metal_Estimator_V2__c;
                    lmgList.add(lmgObj);
                    
                    opp.Metal_Price__c = null;
                    opp.M_Est_Start_Date__c = null;
                    opp.M_Est_Completion_Date__c = null;
                    opp.M_Est_Man_Hours_Shop__c = null;
                    opp.M_Est_Man_Hours_Field__c = null;
                    opp.M_Crew_Size__c = null;
                    opp.M_Material_Cost__c = null;
                    opp.M_Shop_Labor_Cost__c = null;
                    opp.M_Field_Labor_Cost__c = null;
                    opp.Metal_GPM__c = null;
                    //opp.Metal_Estimator_V2__c = null;
                }
            }
            else if(opp.Metal_Lost__c == false && oldOppMap.get(opp.Id).Metal_Lost__c == true){
                if(TriggerStopper.stopOpp == false){
                    lostOpptyMap.put(opp.Id,opp);   
                }
            }
        }
        
        List<Lost_metal_glass__c> lostMGList = [Select Name,Metal_Price__c,M_Est_Start_Date__c,M_Est_Completion_Date__c,M_Est_Man_Hours_Shop__c,M_Est_Man_Hours_Field__c,M_Crew_Size__c,
                                               M_Material_Cost__c,M_Shop_Labor_Cost__c,M_Field_Labor_Cost__c,Metal_GPM__c,Opportunity__c, Metal_Estimator__c From Lost_metal_glass__c 
                                               Where Opportunity__c IN :lostOpptyMap.keyset()];
        
        for(Lost_metal_glass__c lmgObj : lostMGList){
            for(Id oppId : lostOpptyMap.keyset()){
                if(oppId == lmgObj.Opportunity__c){
                    lostOpptyMap.get(oppId).Metal_Price__c = lmgObj.Metal_Price__c;
                    lostOpptyMap.get(oppId).M_Est_Start_Date__c = lmgObj.M_Est_Start_Date__c;
                    lostOpptyMap.get(oppId).M_Est_Completion_Date__c = lmgObj.M_Est_Completion_Date__c;
                    lostOpptyMap.get(oppId).M_Est_Man_Hours_Shop__c = lmgObj.M_Est_Man_Hours_Shop__c;
                    lostOpptyMap.get(oppId).M_Est_Man_Hours_Field__c = lmgObj.M_Est_Man_Hours_Field__c;
                    lostOpptyMap.get(oppId).M_Crew_Size__c = lmgObj.M_Crew_Size__c;
                    lostOpptyMap.get(oppId).M_Material_Cost__c = lmgObj.M_Material_Cost__c;
                    lostOpptyMap.get(oppId).M_Shop_Labor_Cost__c = lmgObj.M_Shop_Labor_Cost__c;
                    lostOpptyMap.get(oppId).M_Field_Labor_Cost__c = lmgObj.M_Field_Labor_Cost__c;
                    lostOpptyMap.get(oppId).Metal_GPM__c = lmgObj.Metal_GPM__c;
                    //lostOpptyMap.get(oppId).Metal_Estimator_V2__c = lmgObj.Metal_Estimator__c;
                    
                   /* lmgObj.Metal_Price__c = null;
                    lmgObj.M_Est_Start_Date__c = null;
                    lmgObj.M_Est_Completion_Date__c = null;
                    lmgObj.M_Est_Man_Hours_Shop__c = null;
                    lmgObj.M_Est_Man_Hours_Field__c = null;
                    lmgObj.M_Crew_Size__c = null;
                    lmgObj.M_Material_Cost__c = null;
                    lmgObj.M_Shop_Labor_Cost__c = null;
                    lmgObj.M_Field_Labor_Cost__c = null;
                    lmgObj.Metal_GPM__c = null;
                    lmgList.add(lmgObj); */
                }
            }
        }
        if(!lmgList.isEmpty()){
            Database.upsert(lmgList,false);
        }
    }
}