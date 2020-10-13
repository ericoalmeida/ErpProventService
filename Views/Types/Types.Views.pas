unit Types.Views;

interface

type
   TTypeMessageView = (tmInformation, tmConfirmation, tmError, tmWarning,
     tmRequired);

   TTypeListingPrograms = (tpMNG0001AView, tpMNG0002AView, tpMNG0003AView,
     tpMNG0004AView, tpMNG0005AView, tpMNG0006AView, tpASS0001AView,
     tpASS0002AView, tpORD0001AView, tpORD0002AView, tpORD0003AView,
     tpSTO0001AView, tpREC0001AView, tpPAY0001AView, tpBDG0001AView, 
     tpBDG0002AView);

   TTypeRegisterPrograms = (trMNG0001BView, trMNG0002BView, trMNG0003BView,
     trMNG0004BView, trMNG0005BView, trMNG0006BView, trASS0001BView,
     trASS0002BView, trORD0001BView, trORD0002BView, trORD0003BView,
     trSTO0001BView, trREC0001BView, trPAY0001BView, trBDG0001BView);

   TTypeSearchPrograms = (tsMNG0001CView, tsMNG0002CView, tsMNG0003CView,
     tsMNG0004CView, tsREC0001CView, tsPAY0001CView, tsORD0002CView,
     tsASS0002CView, tsORD0001CView, tsSTO0001DView);

   TTypeReportPrograms = (trORD0003DReport);

implementation

end.
