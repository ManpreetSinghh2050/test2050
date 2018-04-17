@isTest
private class OpptyChartControllerTest {

    static testMethod void billingTestPositive() {
        Date sD = System.today().addMonths(-1);
        Date eD = System.today().addMonths(1);
        
        List<Opportunity_Year_Index__c> oppIndexList = new List<Opportunity_Year_Index__c>();
        List<API_Indexing__c> apiIndexList = new List<API_Indexing__c>();
        
        Opportunity_Year_Index__c sIndex = new Opportunity_Year_Index__c();
        sIndex.Name = '2017';
        sIndex.startIndex__c = 1;
        sIndex.endIndex__c = 12;
        insert sIndex;
        
        API_Indexing__c sAPI,eAPI;
        
        sAPI = new API_Indexing__c();
        sAPI.Name = 'May-17';
        sAPI.GlassApiName__c = 'May_17_G__c';
        sAPI.MetalApiName__c = 'May_17_M__c';
        sAPI.API_Index_Value__c = 5;
        apiIndexList.add(sAPI);
        
        eAPI = new API_Indexing__c();
        eAPI.Name = 'July-17';
        eAPI.GlassApiName__c = 'July_17_G__c';
        eAPI.MetalApiName__c = 'July_17_M__c';
        eAPI.API_Index_Value__c = 7;
        apiIndexList.add(eAPI);
        
        Database.insert(apiIndexList);
        
        Opportunity opp = new Opportunity();
        opp.Name = 'Test Billing Opportunity 1';
        opp.Amount = 5000000.0;
        opp.StageName = 'Active';
        opp.CloseDate = System.Today().addDays(10);
        opp.G_Est_Start_Date__c = System.Today().addMonths(-1);
        opp.G_Est_Completion_Date__c = System.Today().addDays(5);
        opp.M_Est_Start_Date__c = System.Today().addMonths(-1);
        opp.M_Est_Completion_Date__c = System.Today().addDays(5);
        opp.Field_Completion_Date__c = System.Today().addMonths(1);
        opp.G_Est_Man_Hours_Shop__c = 10;
        opp.G_Est_Man_Hours_Field__c = 5;
        opp.G_Crew_Size__c = 20;
        opp.Material_Cost__c = 5000.0;
        opp.Shop_Labor_Cost__c = 2500.0;
        opp.Field_Labor_Costs__c = 2000.0;
        opp.Glass_GPM__c = 60;
        opp.Glass_Price__c = 400000.0;
        opp.Metal_Price__c = 200000.0;
        opp.M_Est_Man_Hours_Shop__c = 6;
        opp.M_Est_Man_Hours_Field__c = 5;
        opp.M_Crew_Size__c = 15;
        opp.M_Material_Cost__c = 3500.0;
        opp.M_Shop_Labor_Cost__c = 2000.0;
        opp.M_Field_Labor_Cost__c = 1000.0;
        opp.Metal_GPM__c = 40;
        insert opp;
        
        PageReference pageRef = Page.OpptyBillingGraph;
        Test.setCurrentPage(pageRef);
        Test.startTest();
            ApexPages.StandardController oppController = new ApexPages.StandardController(opp);
            OpptyChartController oppObj = new OpptyChartController(oppController);
            OpptyChartController.glassWrapper glassWrap = new OpptyChartController.glassWrapper(sAPI.Name,'$'+ String.valueOf(opp.Glass_Price__c));
            OpptyChartController.metalWrapper metalWrap = new OpptyChartController.metalWrapper(eAPI.Name,'$'+ String.valueOf(opp.Metal_Price__c));
            oppObj.getGlassData();
            oppObj.getMetalData();
            OpptyChartController.getIndexApiList(sD,eD);
        Test.stopTest();
    }
    
    static testMethod void billingTestNegative() {
        Date sD = System.today().addDays(-1);
        Date eD = System.today().addDays(1);
        
        Opportunity opp = new Opportunity();
        opp.Name = 'Test Billing Opportunity 2';
        opp.Amount = 5000000.0;
        opp.StageName = 'Active';
        opp.CloseDate = System.Today().addDays(10);
        opp.G_Est_Start_Date__c = System.Today().addMonths(-1);
        opp.G_Est_Completion_Date__c = System.Today().addDays(5);
        opp.M_Est_Start_Date__c = System.Today().addMonths(-1);
        opp.M_Est_Completion_Date__c = System.Today().addDays(5);
        opp.Field_Completion_Date__c = System.Today().addMonths(1);
        opp.G_Est_Man_Hours_Shop__c = 10;
        opp.G_Est_Man_Hours_Field__c = 5;
        opp.G_Crew_Size__c = 20;
        opp.Material_Cost__c = 5000.0;
        opp.Shop_Labor_Cost__c = 2500.0;
        opp.Field_Labor_Costs__c = 2000.0;
        opp.Glass_GPM__c = 60;
        opp.M_Est_Man_Hours_Shop__c = 6;
        opp.M_Est_Man_Hours_Field__c = 5;
        opp.M_Crew_Size__c = 15;
        opp.M_Material_Cost__c = 3500.0;
        opp.M_Shop_Labor_Cost__c = 2000.0;
        opp.M_Field_Labor_Cost__c = 1000.0;
        opp.Metal_GPM__c = 40;
        insert opp;
        
        PageReference pageRef = Page.OpptyBillingGraph;
        Test.setCurrentPage(pageRef);
        Test.startTest();
            ApexPages.StandardController oppController = new ApexPages.StandardController(opp);
            OpptyChartController oppObj = new OpptyChartController(oppController);
            OpptyChartController.glassWrapper glassWrap = new OpptyChartController.glassWrapper('Test Glass','$100');
            OpptyChartController.metalWrapper metalWrap = new OpptyChartController.metalWrapper('Test Metal','$50');
            oppObj.getGlassData();
            oppObj.getMetalData();
            OpptyChartController.getIndexApiList(sD,eD);
        Test.stopTest();
    }
}