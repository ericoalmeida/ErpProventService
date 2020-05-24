unit OrderOfServiceFactory.View;

interface

uses OrderOfServiceFactory.View.Interf, Types.Views, Base.View.Interf,
  BaseReport.View.interf;

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
    function showORD0003DReport: iORD0003DReport;

  end;

implementation

{ TOrdemOfServiceFactoryView }

uses ORD0001AView, ORD0001BView, ORD0002AView, ORD0002BView, ORD0003AView,
  ORD0003BView,
  ORD0002CView, ORD0001CView, ORD0003DView;

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

function TOrderOfServiceFactoryView.showORD0003DReport: iORD0003DReport;
begin
  Result := TFORD0003DView.New;
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
  case AValue of
    tsORD0001CView:
      Result := TFORD0001CView.New;

    tsORD0002CView:
      Result := TFORD0002CView.New;
  end;
end;

end.
