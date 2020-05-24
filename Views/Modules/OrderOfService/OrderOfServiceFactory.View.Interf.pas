unit OrderOfServiceFactory.View.Interf;

interface

uses Base.View.Interf, Types.Views, BaseReport.View.interf;

type
  iOrderOfServiceFactoryView = interface
    ['{3F385DDC-16D4-4C54-85D3-BA82EE71C910}']
    function showProgramOfListing(AValue: TTypeListingPrograms): iBaseListView;
    function showProgramOfRegister(AValue: TTypeRegisterPrograms)
      : iBaseRegisterView;
    function showProgramOfSearch(AValue: TTypeSearchPrograms): IBaseSearchView;

    function showORD0003DReport: iORD0003DReport;
  end;

implementation

end.
