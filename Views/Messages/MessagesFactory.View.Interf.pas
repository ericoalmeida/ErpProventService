unit MessagesFactory.View.Interf;

interface

uses Types.Views, Base.View.interf;

type
  iMessagesFactoryView = interface
    ['{CFFCE34C-7690-4231-876F-F7E94616457C}']
    function typeMessage(AValue: TTypeMessageView): iBaseMessageView;
  end;

implementation

end.
