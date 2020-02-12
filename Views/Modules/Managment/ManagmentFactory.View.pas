unit ManagmentFactory.View;

interface

uses ManagmentFactory.View.Interf, Base.View.Interf, Types.Views;

type
  TManagmentFactoryView = class(TInterfacedObject, iManagmentFactoryView)
  private
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iManagmentFactoryView;

    function showProgramOfListing(AValue: TTypeListingPrograms): iBaseListView;
    function showProgramOfRegister(AValue: TTYpeRegisterPrograms)
      : iBaseRegisterView;

  end;

implementation

{ TManagmentFactoryView }

uses MNG0001AView, MNG0001BView;

constructor TManagmentFactoryView.Create;
begin

end;

destructor TManagmentFactoryView.Destroy;
begin

  inherited;
end;

class function TManagmentFactoryView.New: iManagmentFactoryView;
begin
  Result := Self.Create;
end;

function TManagmentFactoryView.showProgramOfListing
  (AValue: TTypeListingPrograms): iBaseListView;
begin
  case AValue of
    tpMNG0001AView:
      Result := TFMNG0001AView.New;
  end;
end;

function TManagmentFactoryView.showProgramOfRegister
  (AValue: TTYpeRegisterPrograms): iBaseRegisterView;
begin
  case AValue of
     trMNG0001BView:
       Result := TFMNG0001BView.New;
   end;
end;

end.
