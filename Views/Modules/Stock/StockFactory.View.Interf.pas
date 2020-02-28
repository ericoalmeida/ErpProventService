unit StockFactory.View.Interf;

interface

uses Base.View.Interf, Types.Views;

type
  iStockFactoryView = interface
    ['{BF7E0076-AB26-49AD-B12B-EDFE63393874}']
    function showProgramOfListing(AValue: TTypeListingPrograms): iBaseListView;
    function showProgramOfRegister(AValue: TTypeRegisterPrograms)
      : iBaseRegisterView;
    function showProgramOfSearch(AValue: TTypeSearchPrograms): IBaseSearchView;
  end;

implementation

end.
