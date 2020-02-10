unit MessagesFactory.View;

interface

uses MessagesFactory.View.Interf, Types.Views, Base.View.interf;

type
  TMessagesFactoryView = class sealed(TInterfacedObject, iMessagesFactoryView)
  private
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iMessagesFactoryView;


    function typeMessage(AValue: TTypeMessageView): iBaseMessageView;

  end;

implementation

{ TMessagesFactoryView }

uses MSG0001.View, MSG0002.View, MSG0003.View, MSG0004.View;

constructor TMessagesFactoryView.Create;
begin

end;

destructor TMessagesFactoryView.Destroy;
begin

  inherited;
end;

class function TMessagesFactoryView.New: iMessagesFactoryView;
begin
  Result := Self.Create;
end;

function TMessagesFactoryView.typeMessage(AValue: TTypeMessageView): iBaseMessageView;
begin
  case AValue of
    tmInformation: Result := TFMSG0001View.new;
    tmConfirmation: Result := TFMSG0002View.new;
    tmError: Result := TFMSG0003View.new;
    tmWarning: Result := TFMSG0004View.new;
  end;
end;

end.
