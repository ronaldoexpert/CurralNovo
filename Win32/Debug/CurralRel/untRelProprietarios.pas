unit untRelProprietarios;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, UCrpeClasses, UCrpe32;

type
  TfrmRelProprietario = class(TForm)
    pnlPrincipal: TPanel;
    grpFiltro: TGroupBox;
    edtDescricao: TEdit;
    btnPesquisa: TBitBtn;
    edtCodigo: TEdit;
    pnlBotton: TPanel;
    btnImprimir: TBitBtn;
    btnFechar: TBitBtn;
    chkComAnimais: TCheckBox;
    crpe1: TCrpe;
    procedure btnFecharClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnImprimirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure PesquisaProprietario(vStatus : Boolean);
  end;

var
  frmRelProprietario: TfrmRelProprietario;

implementation

uses untDM, untPesquisa;

{$R *.dfm}

procedure TfrmRelProprietario.btnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TfrmRelProprietario.PesquisaProprietario(vStatus: Boolean);
begin
  if vStatus = True then
  begin
    if Trim(edtCodigo.Text) <> '' then
    begin
      DM.clntdtstProprietarios.Close;
      DM.sqldtstProprietarios.CommandText := 'Select * from PRODUTOR where ID = ' + QuotedStr(edtCodigo.Text);
      DM.clntdtstProprietarios.open;
      if DM.clntdtstProprietarios.RecordCount > 0 then
      begin
        edtDescricao.Text :=  DM.clntdtstProprietarios.FieldByName('nome').AsString;
      end
      else
      begin
        Application.MessageBox('Registro não encontrado.', 'Curral Novo', MB_OK);
        edtDescricao.Clear;
        edtCodigo.SetFocus;
      end;
    end;
  end
  else
  begin
    try
      frmPesquisa := TfrmPesquisa.Create(Self);
      frmPesquisa.vTabela := 'PRODUTOR';
      frmPesquisa.vComando := 'Select ID, NOME from PRODUTOR';
      frmPesquisa.vTela := 'REL_PROPRIETARIOS';
      frmPesquisa.ShowModal;
    finally
      frmPesquisa.Release;
    end;
  end;
end;

procedure TfrmRelProprietario.btnPesquisaClick(Sender: TObject);
begin
  PesquisaProprietario(False);
end;

procedure TfrmRelProprietario.edtCodigoExit(Sender: TObject);
begin
  if edtCodigo.Text <> '' then
    PesquisaProprietario(True);
end;

procedure TfrmRelProprietario.edtCodigoKeyPress(Sender: TObject;
  var Key: Char);
begin
  If not( key in['0'..'9',#08] ) then
    key := #0;
end;

procedure TfrmRelProprietario.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If key = #13 then
  Begin
    Key:= #0;
    Perform(Wm_NextDlgCtl,0,0);
  end;
end;

procedure TfrmRelProprietario.btnImprimirClick(Sender: TObject);
begin
  Crpe1.DiscardSavedData;
  if chkComAnimais.Checked = False then
    Crpe1.ReportName := 'Relatorios\PropCad.rpt'
  else
    Crpe1.ReportName := 'Relatorios\PropAnimais.rpt';
  Crpe1.ParamByName('CODIGO', '').CurrentValue := edtCodigo.Text;
  Crpe1.Execute;
  Crpe1.SetFocus;
end;

end.
