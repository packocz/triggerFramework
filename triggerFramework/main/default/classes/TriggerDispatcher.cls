/**
 * Main worker of the TriggerFramework
 * @author Aleš Remta
 * @created 2019-02-08
 *
 * Used TriggerConfig__mdt custom metadata to bind TriggerHandler implementation to SObjects. If implementation is generic
 * the same class can be bound to more than one SObject. Each sObject can have many active handlers bound to it. In such cases
 * the OrderOfExecution__c value is used to determine the order in which the handlers are called. (please be mindful of execution limits)
 *
 * For the metadata binding of TriggerHandler implementation to work a single-line trigger needs to be in place
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
 *     new TriggerDispatcher(Account.getSObjectType()).runTriggerHandlers();
 * }
 *
 * SUGGESTIONS:
 * Do not use Order values that immediatelly follow each other if possible (1,2,3), more spacing will allow for future dependant implementations
 * withing the org to inject between the handlers if required. i.e. 100 and 200 allows you to add 150 in a later separate package of which your
 * original package does not need to know.
 *
 */
public without sharing class TriggerDispatcher {
	@TestVisible
	private static Boolean runTriggers = true;
	@TestVisible
	private sObjectType currentSObjectType;
	@TestVisible
	private List<TriggerConfig__mdt> handlerConfigs;

	public TriggerDispatcher(Schema.sObjectType soType) {
		this.currentSObjectType = soType;
		this.handlerConfigs = [
			SELECT DeveloperName, ClassName__c
			FROM TriggerConfig__mdt
			WHERE TriggerSObject__r.QualifiedApiName = :soType.getDescribe().getName() AND Active__c = true
			ORDER BY OrderOfExecution__c ASC
		];
	}

	public void runTriggerHandlers() {
		if (handlerConfigs.isEmpty()) {
			System.debug(LoggingLevel.FINE, 'Trigger Framework: No active triggers for ' + this.currentSObjectType);
			return;
		}

		for (TriggerConfig__mdt conf : this.handlerConfigs) {
			TriggerHandler handler = buildTriggerHandlerInstance(conf.ClassName__c);
			if (TriggerDispatcher.runTriggers) {
				handler.run();
			}
		}
	}

	private TriggerHandler buildTriggerHandlerInstance(String triggerHandlerClassName) {
		Type t = Type.forName(triggerHandlerClassName);
		if (t == null) {
			throw new TriggerFrameworkException(
				'Trigger Framework: Invalid Config! Cannot find class [' +
				triggerHandlerClassName +
				']'
			);
		}
		return (TriggerHandler) t.newInstance();
	}
}
