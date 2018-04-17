@isTest
private class OpportunityTriggerHandlerTest {

    static testMethod void oppGlassMetalTest() {
        
        List<Opportunity> oppList = new List<Opportunity>();
        Map<Id,Opportunity> oppMap = new Map<Id,Opportunity>();
        Lost_metal_glass__c lmgObj = new Lost_metal_glass__c();
        
        Opportunity opp1 = new Opportunity();
        opp1.Name = 'Test Opp1 Kovach';
        opp1.Amount = 100000.0;
        opp1.StageName = 'Active';
        opp1.CloseDate = System.today().addDays(10);
        opp1.Glass_Price__c = 60000.0;
        opp1.G_Est_Start_Date__c = System.Today().addDays(-5);
        opp1.G_Est_Completion_Date__c = System.Today().addDays(5);
        opp1.G_Est_Man_Hours_Shop__c = 10;
        opp1.G_Est_Man_Hours_Field__c = 5;
        opp1.G_Crew_Size__c = 20;
        opp1.Material_Cost__c = 5000.0;
        opp1.Shop_Labor_Cost__c = 2500.0;
        opp1.Field_Labor_Costs__c = 2000.0;
        opp1.Glass_GPM__c = 60;
        opp1.Glass_Lost__c = false;
        opp1.Metal_Price__c = 40000.0;
        opp1.M_Est_Start_Date__c = System.Today().addDays(-5);
        opp1.M_Est_Completion_Date__c = System.Today().addDays(5);
        opp1.M_Est_Man_Hours_Shop__c = 6;
        opp1.M_Est_Man_Hours_Field__c = 5;
        opp1.M_Crew_Size__c = 15;
        opp1.M_Material_Cost__c = 3500.0;
        opp1.M_Shop_Labor_Cost__c = 2000.0;
        opp1.M_Field_Labor_Cost__c = 1000.0;
        opp1.Metal_GPM__c = 40;
        opp1.Metal_Lost__c = false;
        oppList.add(opp1);
        
        Opportunity opp2 = new Opportunity();
        opp2.Name = 'Test Opp2 Kovach';
        opp2.Amount = 100000.0;
        opp2.StageName = 'Active';
        opp2.CloseDate = System.today().addDays(10);
        opp2.Glass_Price__c = 60000.0;
        opp2.G_Est_Start_Date__c = System.Today().addDays(-5);
        opp2.G_Est_Completion_Date__c = System.Today().addDays(5);
        opp2.G_Est_Man_Hours_Shop__c = 10;
        opp2.G_Est_Man_Hours_Field__c = 5;
        opp2.G_Crew_Size__c = 20;
        opp2.Material_Cost__c = 5000.0;
        opp2.Shop_Labor_Cost__c = 2500.0;
        opp2.Field_Labor_Costs__c = 2000.0;
        opp2.Glass_GPM__c = 60;
        opp2.Glass_Lost__c = true;
        opp2.Metal_Price__c = 40000.0;
        opp2.M_Est_Start_Date__c = System.Today().addDays(-5);
        opp2.M_Est_Completion_Date__c = System.Today().addDays(5);
        opp2.M_Est_Man_Hours_Shop__c = 6;
        opp2.M_Est_Man_Hours_Field__c = 5;
        opp2.M_Crew_Size__c = 15;
        opp2.M_Material_Cost__c = 3500.0;
        opp2.M_Shop_Labor_Cost__c = 2000.0;
        opp2.M_Field_Labor_Cost__c = 1000.0;
        opp2.Metal_GPM__c = 40;
        opp2.Metal_Lost__c = true;
        oppList.add(opp2);
        
        Database.insert(oppList);
        
        oppMap.put(opp1.Id,opp1);
        oppMap.put(opp2.Id,opp2);
        
        opp1.Glass_Lost__c = true;
        opp1.Metal_Lost__c = true;
        opp2.Glass_Lost__c = false;
        opp2.Metal_Lost__c = false;
        
        Database.update(oppList);
        
        Test.startTest();
        	OpportunityTriggerHandler.setLostGlass(oppList,oppMap);
        	OpportunityTriggerHandler.setLostMetal(oppList,oppMap);
        Test.stopTest();
    }
}