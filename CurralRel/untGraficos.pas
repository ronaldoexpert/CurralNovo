unit untGraficos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, UCrpeClasses, UCrpe32, ComCtrls, ExtCtrls, DateUtils;

type
  TfrmRelGraficos = class(TForm)
    pnlClient: TPanel;
    lblate: TLabel;
    dtpDtInicio: TDateTimePicker;
    dtpDtFim: TDateTimePicker;
    crpe1: TCrpe;
    pnlBotton: TPanel;
    btnImprimir: TBitBtn;
    btnFechar: TBitBtn;
    procedure btnFecharClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelGraficos: TfrmRelGraficos;

implementation

{$R *.dfm}

procedure TfrmRelGraficos.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmRelGraficos.btnImprimirClick(Sender: TObject);
begin
  Crpe1.DiscardSavedData;       
  Crpe1.ReportName := 'Relatorios\GrafInseminacao.rpt';
  Crpe1.ParamByName('DTINICIO', '').CurrentValue := DateToStr(dtpDtInicio.Date);
  Crpe1.ParamByName('DTFIM', '').CurrentValue := DateToStr(dtpDtFim.Date);
  Crpe1.Execute;
  Crpe1.SetFocus;
end;

procedure TfrmRelGraficos.FormActivate(Sender: TObject);
begin
  dtpDtInicio.Date := StartOfTheMonth(Date);
  dtpDtFim.Date := EndOfTheMonth(Date);
end;

procedure TfrmRelGraficos.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If key = #13 then
  Begin
    Key:= #0;
    Perform(Wm_NextDlgCtl,0,0);
  end;
end;

end.
