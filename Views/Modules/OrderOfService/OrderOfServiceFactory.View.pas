unit OrderOfServiceFactory.View;

interface

uses OrderOfServiceFactory.View.Interf, Types.Views, Base.View.Interf;

type
  TOrderOfServiceFactoryView = class(TInterfacedObject,
    iOrderOfServiceFactoryView)
  private
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iOrderOfServiceFactoryView;

    function showProgramOfListing(AValue: TTypeListingPrograms): iBaseListView;
    function showProgramOfRegister(AValue: TTypeRegisterPrograms)
      : iBaseRegisterView;
    function showProgramOfSearch(AValue: TTypeSearchPrograms): IBaseSearchView;

  end;

implementation

{ TOrdemOfServiceFactoryView }

uses ORD0001AView, ORD0001BView, ORD0002AView, ORD0002BView, ORD0003AView, ORD0003BView;

constructor TOrderOfServiceFactoryView.Create;
begin

end;

destructor TOrderOfServiceFactoryView.Destroy;
begin

  inherited;
end;

class function TOrderOfServiceFactoryView.New: iOrderOfServiceFactoryView;
begin
  Result := Self.Create;
end;

function TOrderOfServiceFactoryView.showProgramOfListing
  (AValue: TTypeListingPrograms): iBaseListView;
begin
  case AValue of
    tpORD0001AView:
      Result := TFORD0001AView.New;

    tpORD0002AView:
      Result := TFORD0002AView.New;

    tpORD0003AView:
      Result := TFORD0003AView.New;
  end;
end;

function TOrderOfServiceFactoryView.showProgramOfRegister
  (AValue: TTypeRegisterPrograms): iBaseRegisterView;
begin
  case AValue of
    trORD0001BView:
      Result := TFORD0001BView.New;

    trORD0002BView:
      Result := TFORD0002BView.New;

    trORD0003BView:
      Result := TFORD0003BView.New;
  end;
end;

function TOrderOfServiceFactoryView.showProgramOfSearch
  (AValue: TTypeSearchPrograms): IBaseSearchView;
begin

end;

end.
