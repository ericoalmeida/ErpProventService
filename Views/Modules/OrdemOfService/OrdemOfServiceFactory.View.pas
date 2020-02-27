unit OrdemOfServiceFactory.View;

interface

uses OrdemOfServiceFactory.View.Interf, Types.Views, Base.View.Interf,
  ORD0001AView;

type
  TOrdemOfServiceFactoryView = class(TInterfacedObject,
    iOrdemOfServiceFactoryView)
  private
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iOrdemOfServiceFactoryView;

    function showProgramOfListing(AValue: TTypeListingPrograms): iBaseListView;
    function showProgramOfRegister(AValue: TTypeRegisterPrograms)
      : iBaseRegisterView;
    function showProgramOfSearch(AValue: TTypeSearchPrograms): IBaseSearchView;

  end;

implementation

{ TOrdemOfServiceFactoryView }

constructor TOrdemOfServiceFactoryView.Create;
begin

end;

destructor TOrdemOfServiceFactoryView.Destroy;
begin

  inherited;
end;

class function TOrdemOfServiceFactoryView.New: iOrdemOfServiceFactoryView;
begin
  Result := Self.Create;
end;

function TOrdemOfServiceFactoryView.showProgramOfListing
  (AValue: TTypeListingPrograms): iBaseListView;
begin
  case AValue of
    tpORD0001AView:
      Result := TFORD0001AView.New;
  end;
end;

function TOrdemOfServiceFactoryView.showProgramOfRegister
  (AValue: TTypeRegisterPrograms): iBaseRegisterView;
begin
  case AValue of
    trMNG0001BView:
      ;
  end;

end;

function TOrdemOfServiceFactoryView.showProgramOfSearch
  (AValue: TTypeSearchPrograms): IBaseSearchView;
begin

end;

end.
