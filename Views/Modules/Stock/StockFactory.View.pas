unit StockFactory.View;

interface

uses StockFactory.View.Interf, Base.View.Interf, Types.Views;

type
  TStockFactoryView = class(TInterfacedObject, iStockFactoryView)
  private
  public
    constructor Create;
    destructor Destroy; override;

    class function New: iStockFactoryView;

    function showProgramOfListing(AValue: TTypeListingPrograms): iBaseListView;
    function showProgramOfRegister(AValue: TTypeRegisterPrograms)
      : iBaseRegisterView;
    function showProgramOfSearch(AValue: TTypeSearchPrograms): IBaseSearchView;
  end;

implementation

{ TStockFactoryView }

uses STO0001AView, STO0001BView;

constructor TStockFactoryView.Create;
begin

end;

destructor TStockFactoryView.Destroy;
begin

  inherited;
end;

class function TStockFactoryView.New: iStockFactoryView;
begin
  Result := Self.Create;
end;

function TStockFactoryView.showProgramOfListing(AValue: TTypeListingPrograms)
  : iBaseListView;
begin
  case AValue of
    tpSTO0001AView:
      Result := TFSTO0001AView.New;
  end;
end;

function TStockFactoryView.showProgramOfRegister(AValue: TTypeRegisterPrograms)
  : iBaseRegisterView;
begin
  case AValue of
    trSTO0001BView:
      Result := TFSTO0001BView.New;
  end;
end;

function TStockFactoryView.showProgramOfSearch(AValue: TTypeSearchPrograms)
  : IBaseSearchView;
begin

end;

end.
