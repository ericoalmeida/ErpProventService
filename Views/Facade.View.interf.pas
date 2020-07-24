unit Facade.View.interf;

interface

uses MessagesFactory.View.interf, ModulesFacade.View.interf;

type
   iFacadeView = interface
      ['{74CF185D-C7CE-437A-BF34-AB1BD16EBB8E}']
      function messagesFactoryView: iMessagesFactoryView;

      function modulesFacadeView: iModulesFacadeView;
   end;

implementation

end.
