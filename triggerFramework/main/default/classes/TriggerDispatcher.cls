/**
 * Main worker of the TriggerFramework
 * @author Aleš Remta
 * @created 2019-02-08
 *
 * Used TriggerConfig__mdt custom metadata to bind ITriggerHandler implementation to SObjects. If implementation is generic
 * the same class can be bound to more than one SObject. Each sObject can have many active handlers bound to it. In such cases
 * the Order_of_Execution__c value is used to determine the order in which the handlers are called. (please be mindful of execution limits)
 *
 * For the metadata binding of ITriggerHandler implementation to work a single-line trigger needs to be in place
 * e.g. 
 *  trigger AccountTriggerExample on Account (
 *     before insert, 
 *     before update,
 *     before delete,
 *     after insert,
 *     after update,
 *     after delete,
 *     after undelete) {
 *         
 *     TriggerDispatcher.handle(Account.getSObjectType());
 * }
 * 
 * SUGGESTIONS:
 * Do not use Order values that immediatelly follow each other if possible (1,2,3), more spacing will allow for future dependant implementations
 * withing the org to inject between the handlers if required. i.e. 100 and 200 allows you to add 150 in a later separate package of which your
 * original package does not need to know.
 * 
 */
public class TriggerDispatcher {

    public static void handle(Schema.sObjectType soType)
    {
        List<TriggerConfig__mdt> handlerConfigs = [
            SELECT DeveloperName, Class_Name__c
            FROM TriggerConfig__mdt
            WHERE Trigger_sObject__c =: soType.getDescribe().getName() AND
                Active__c = TRUE AND Unit_Test_Only__c =: Test.isRunningTest()
            ORDER BY Order_of_Execution__c ASC
        ];

        if(handlerConfigs.isEmpty()) {
            system.debug('Trigger Framework: No active triggesr for ' + soType);
            return;
        }

        List<ITriggerHandler> handlers = new List<ITriggerHandler>();
        Map<TriggerFrameworkAction, Boolean> initActions = new Map<TriggerFrameworkAction, Boolean>();
        Map<TriggerFrameworkAction, Boolean> doActions = new Map<TriggerFrameworkAction, Boolean>();

        for(TriggerConfig__mdt conf : handlerConfigs) {
            Type t = Type.forName(conf.Class_Name__c);
            if(t == null) {
                throw new TriggerFrameworkException('Trigger Framework: Invalid Config! Cannot find class ['+conf.Class_Name__c+']');
            }
            ITriggerHandler handler = (ITriggerHandler)t.newInstance();

            for(TriggerFrameworkAction action : TriggerFrameworkAction.values()) {
                if(handler.shouldDoInit(action)) {
                    initActions.put(action, true);
                }
                else if(!initActions.containsKey(action)){
                    initActions.put(action, false);
                }

                if(handler.shouldDoAction(action)) {
                    doActions.put(action, true);
                }
                else if(!doActions.containsKey(action)){
                    doActions.put(action, false);
                }
            }

            handlers.add(handler);
        }

        if(Trigger.isInsert) {            
            if(Trigger.isBefore) {
                if(initActions.get(TriggerFrameworkAction.BEFORE_INSERT_BULK)) {
                    for(ITriggerHandler handler : handlers) {
                        handler.beforeInsertInitBulk(Trigger.new);
                    }
                }
                if(initActions.get(TriggerFrameworkAction.BEFORE_INSERT)) {
                    for(sObject o : Trigger.new) {
                        for(ITriggerHandler handler : handlers) {
                            handler.beforeInsertInit(o);
                        }
                    }
                }
                if(doActions.get(TriggerFrameworkAction.BEFORE_INSERT_BULK)) {
                    for(ITriggerHandler handler : handlers) {
                        handler.onBeforeInsertBulk(Trigger.new);
                    }
                } 
                if(doActions.get(TriggerFrameworkAction.BEFORE_INSERT)) {
                    for(sObject o : Trigger.new) {
                        for(ITriggerHandler handler : handlers) {
                            handler.onBeforeInsert(o);
                        }
                    }
                }  
                for(ITriggerHandler handler : handlers) {
                    handler.beforeInsertFinally();  
                }             
            }
            if(Trigger.isAfter) {
                if(initActions.get(TriggerFrameworkAction.AFTER_INSERT_BULK)) {
                    for(ITriggerHandler handler : handlers) {
                        handler.afterInsertInitBulk(Trigger.newMap);
                    }
                }
                if(initActions.get(TriggerFrameworkAction.AFTER_INSERT)) {
                    for(sObject o : Trigger.new) {
                        for(ITriggerHandler handler : handlers) {
                            handler.afterInsertInit(o);
                        }
                    }
                }
                if(doActions.get(TriggerFrameworkAction.AFTER_INSERT_BULK)) {
                    for(ITriggerHandler handler : handlers) {
                        handler.onAfterInsertBulk(Trigger.newMap);
                    }
                }
                if(doActions.get(TriggerFrameworkAction.AFTER_INSERT)) {
                    for(sObject o : Trigger.new) {
                        for(ITriggerHandler handler : handlers) {
                            handler.onAfterInsert(o);
                        }
                    }
                }
                for(ITriggerHandler handler : handlers) {
                    handler.afterInsertFinally();
                }
            }
        }
        if(Trigger.isUpdate) {
            if(Trigger.isBefore) {
                if(initActions.get(TriggerFrameworkAction.BEFORE_UPDATE_BULK)) {
                    for(ITriggerHandler handler : handlers) {
                        handler.beforeUpdateInitBulk(Trigger.oldMap, Trigger.newMap);
                    }
                }
                if(initActions.get(TriggerFrameworkAction.BEFORE_UPDATE)) {
                    for(sObject o : Trigger.new) {
                        for(ITriggerHandler handler : handlers) {
                            handler.beforeUpdateInit(Trigger.oldMap.get(o.Id), o);
                        }
                    }
                }
                if(doActions.get(TriggerFrameworkAction.BEFORE_UPDATE_BULK)) {
                    for(ITriggerHandler handler : handlers) {
                        handler.onBeforeUpdateBulk(Trigger.oldMap, Trigger.newMap);
                    }
                } 
                if(doActions.get(TriggerFrameworkAction.BEFORE_UPDATE)) {
                    for(sObject o : Trigger.new) {
                        for(ITriggerHandler handler : handlers) {
                            handler.onBeforeUpdate(Trigger.oldMap.get(o.Id), o);
                        }
                    }
                } 
                for(ITriggerHandler handler : handlers) { 
                    handler.beforeUpdateFinally();         
                }      
            }
            if(Trigger.isAfter) {
                if(initActions.get(TriggerFrameworkAction.AFTER_UPDATE_BULK)) {
                    for(ITriggerHandler handler : handlers) {
                        handler.afterUpdateInitBulk(Trigger.oldMap, Trigger.newMap);
                    }
                }
                if(initActions.get(TriggerFrameworkAction.AFTER_UPDATE)) {
                    for(sObject o : Trigger.new) {
                        for(ITriggerHandler handler : handlers) {
                            handler.afterUpdateInit(Trigger.oldMap.get(o.Id), o);
                        }
                    }
                }
                if(doActions.get(TriggerFrameworkAction.AFTER_UPDATE_BULK)) {
                    for(ITriggerHandler handler : handlers) {
                        handler.onAfterUpdateBulk(Trigger.oldMap, Trigger.newMap);
                    }
                }
                if(doActions.get(TriggerFrameworkAction.AFTER_UPDATE)) {
                    for(sObject o : Trigger.new) {
                        for(ITriggerHandler handler : handlers) {
                            handler.onAfterUpdate(Trigger.oldMap.get(o.Id), o);
                        }
                    }
                }
                for(ITriggerHandler handler : handlers) {
                    handler.afterUpdateFinally();
                }
            }
        }

        if(Trigger.isDelete) {
            if(Trigger.isBefore) {
                if(initActions.get(TriggerFrameworkAction.BEFORE_DELETE_BULK)) {
                    for(ITriggerHandler handler : handlers) {
                        handler.beforeDeleteInitBulk(Trigger.oldMap);
                    }
                }
                if(initActions.get(TriggerFrameworkAction.BEFORE_DELETE)) {
                    for(sObject o : Trigger.old) {
                        for(ITriggerHandler handler : handlers) {
                            handler.beforeDeleteInit(o);
                        }
                    }
                }
                if(doActions.get(TriggerFrameworkAction.BEFORE_DELETE_BULK)) {
                    for(ITriggerHandler handler : handlers) {
                        handler.onBeforeDeleteBulk(Trigger.oldMap);
                    }
                }   
                if(doActions.get(TriggerFrameworkAction.BEFORE_DELETE)) {
                    for(sObject o : Trigger.old) {
                        for(ITriggerHandler handler : handlers) {
                            handler.onBeforeDelete(o);
                        }
                    }
                }
                for(ITriggerHandler handler : handlers) {
                    handler.beforeDeleteFinally();   
                }            
            }
            if(Trigger.isAfter) {
                if(initActions.get(TriggerFrameworkAction.AFTER_DELETE_BULK)) {
                    for(ITriggerHandler handler : handlers) {
                        handler.afterDeleteInitBulk(Trigger.oldMap);
                    }
                }
                if(initActions.get(TriggerFrameworkAction.AFTER_DELETE)) {
                    for(sObject o : Trigger.old) {
                        for(ITriggerHandler handler : handlers) {
                            handler.afterDeleteInit(o);
                        }
                    }
                }
                if(doActions.get(TriggerFrameworkAction.AFTER_DELETE_BULK)) {
                    for(ITriggerHandler handler : handlers) {
                        handler.onAfterDeleteBulk(Trigger.oldMap);
                    }
                }
                if(doActions.get(TriggerFrameworkAction.AFTER_DELETE)) {
                    for(sObject o : Trigger.old) {
                        for(ITriggerHandler handler : handlers) {
                            handler.onAfterDelete(o);
                        }
                    }
                }
                for(ITriggerHandler handler : handlers) {
                    handler.afterDeleteFinally();
                }
            }
        }

        if(Trigger.isUndelete) {
            if(Trigger.isAfter) {
                if(initActions.get(TriggerFrameworkAction.AFTER_UNDELETE_BULK)) {
                    for(ITriggerHandler handler : handlers) {
                        handler.afterUndeleteInitBulk(Trigger.newMap);
                    }
                }
                if(initActions.get(TriggerFrameworkAction.AFTER_UNDELETE)) {
                    for(sObject o : Trigger.new) {
                        for(ITriggerHandler handler : handlers) {
                            handler.afterUndeleteInit(o);
                        }
                    }
                }
                if(doActions.get(TriggerFrameworkAction.AFTER_UNDELETE_BULK)) {
                    for(ITriggerHandler handler : handlers) {
                        handler.onAfterUndeleteBulk(Trigger.newMap);
                    }
                }
                if(doActions.get(TriggerFrameworkAction.AFTER_UNDELETE)) {
                    for(sObject o : Trigger.new) {
                        for(ITriggerHandler handler : handlers) {
                            handler.onAfterUndelete(o);
                        }
                    }
                }
                for(ITriggerHandler handler : handlers) {
                    handler.afterUndeleteFinally();
                }
            }
        }
    }

}
