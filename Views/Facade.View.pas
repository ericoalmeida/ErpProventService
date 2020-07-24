unit Facade.View;

interface

uses Facade.View.interf, MessagesFactory.View.interf, ModulesFacade.View.interf;

type
   TFacadeView = class sealed(TInterfacedObject, iFacadeView)
   private
   public
      constructor Create;
      destructor Destroy; override;

      class function New: iFacadeView;

      function messagesFactoryView: iMessagesFactoryView;

      function modulesFacadeView: iModulesFacadeView;
   end;

implementation

{ TFacadeView }

uses MessagesFactory.View, ModulesFacade.View;

constructor TFacadeView.Create;
begin

end;

destructor TFacadeView.Destroy;
begin

   inherited;
end;

function TFacadeView.messagesFactoryView: iMessagesFactoryView;
begin
   Result := TMessagesFactoryView.New;
end;

function TFacadeView.modulesFacadeView: iModulesFacadeView;
begin
   Result := TModulesFacadeView.New;
end;

class function TFacadeView.New: iFacadeView;
begin
   Result := Self.Create;
end;

end.
