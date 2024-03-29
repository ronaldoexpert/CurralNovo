unit untRelInseminacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, UCrpeClasses, UCrpe32, ComCtrls, DateUtils,
  ExtCtrls;

type
  TfrmRelInseminacoes = class(TForm)
    btnFechar: TBitBtn;
    btnImprimir: TBitBtn;
    dtpDtInicio: TDateTimePicker;
    dtpDtFim: TDateTimePicker;
    crpe1: TCrpe;
    pnlBotton: TPanel;
    pnlClient: TPanel;
    rdgTipos: TRadioGroup;
    rgFiltros: TRadioGroup;
    edtCodigo: TEdit;
    edtDescricao: TEdit;
    btnPesquisa: TBitBtn;
    grpFiltro: TGroupBox;
    lblate: TLabel;
    procedure btnImprimirClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure rgFiltrosClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure PesquisaProprietario(vStatus : Boolean);
    procedure PesquisaVeterinario(vStatus : Boolean);
  end;

var
  frmRelInseminacoes: TfrmRelInseminacoes;

implementation

uses untDM, untPesquisa;

{$R *.dfm}

procedure TfrmRelInseminacoes.btnImprimirClick(Sender: TObject);
begin
  Crpe1.DiscardSavedData;

  if rdgTipos.ItemIndex = 0 then
  begin
    if rgFiltros.ItemIndex = 0 then
    begin
      Crpe1.ReportName := 'Relatorios\Inseminacao.rpt';
    end
    else if rgFiltros.ItemIndex = 1 then
    begin
      Crpe1.ReportName := 'Relatorios\InsemProp.rpt';
    end
    else if rgFiltros.ItemIndex = 2 then
    begin
      Crpe1.ReportName := 'Relatorios\InsemVet.rpt';
    end;
  end
  else if rdgTipos.ItemIndex = 1 then
  begin
    if rgFiltros.ItemIndex = 0 then
    begin
      Crpe1.ReportName := 'Relatorios\InseminacaoConfirm.rpt';
    end
    else if rgFiltros.ItemIndex = 1 then
    begin
      Crpe1.ReportName := 'Relatorios\InsemPropConfirm.rpt';
    end
    else if rgFiltros.ItemIndex = 2 then
    begin
      Crpe1.ReportName := 'Relatorios\InsemVetConfirm.rpt';
    end;
  end
  else if rdgTipos.ItemIndex = 2 then
  begin
    if rgFiltros.ItemIndex = 0 then
    begin
      Crpe1.ReportName := 'Relatorios\InseminacaoNaoConfirm.rpt';
    end
    else if rgFiltros.ItemIndex = 1 then
    begin
      Crpe1.ReportName := 'Relatorios\InsemPropNaoConfirm.rpt';
    end
    else if rgFiltros.ItemIndex = 2 then
    begin
      Crpe1.ReportName := 'Relatorios\InsemVetNaoConfirm.rpt';
    end;
  end;

  Crpe1.ParamByName('CODIGO', '').CurrentValue := edtCodigo.Text;
  Crpe1.ParamByName('DTINICIO', '').CurrentValue := DateToStr(dtpDtInicio.Date);
  Crpe1.ParamByName('DTFIM', '').CurrentValue := DateToStr(dtpDtFim.Date);

  Crpe1.Execute;
  Crpe1.SetFocus;
end;

procedure TfrmRelInseminacoes.FormActivate(Sender: TObject);
begin
  dtpDtInicio.Date := StartOfTheMonth(Date);
  dtpDtFim.Date := EndOfTheMonth(Date);
end;

procedure TfrmRelInseminacoes.btnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TfrmRelInseminacoes.PesquisaProprietario(vStatus: Boolean);
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
        Application.MessageBox('Registro n�o encontrado.', 'Curral Novo', MB_OK);
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
      frmPesquisa.vTela := 'REL_INSEMINACAO';
      frmPesquisa.ShowModal;
    finally
      frmPesquisa.Release;
    end;
  end;
end;

procedure TfrmRelInseminacoes.btnPesquisaClick(Sender: TObject);
begin
  if rgFiltros.ItemIndex = 1 then
  begin
    PesquisaProprietario(False);
  end
  else if rgFiltros.ItemIndex = 2 then
  begin
    PesquisaVeterinario(False);
  end;    
end;

procedure TfrmRelInseminacoes.edtCodigoExit(Sender: TObject);
begin
  if edtCodigo.Text <> '' then
    PesquisaProprietario(True);
end;

procedure TfrmRelInseminacoes.rgFiltrosClick(Sender: TObject);
begin
  if rgFiltros.ItemIndex = 0 then
  begin
    grpFiltro.Visible := False;
  end
  else if rgFiltros.ItemIndex = 1 then
  begin
    grpFiltro.Caption := 'Propriet�rio';
    grpFiltro.Visible := True;
  end
  else if rgFiltros.ItemIndex = 2 then
  begin
    grpFiltro.Caption := 'Veterin�rio';
    grpFiltro.Visible := True;
  end;
  edtCodigo.Clear;
  edtDescricao.Clear;
  edtCodigo.SetFocus;
end;

procedure TfrmRelInseminacoes.PesquisaVeterinario(vStatus: Boolean);
begin
  if vStatus = True then
  begin
    if Trim(edtCodigo.Text) <> '' then
    begin
      DM.clntdtstProprietarios.Close;
      DM.sqldtstProprietarios.CommandText := 'Select * from VETERINARIO where ID = ' + QuotedStr(edtCodigo.Text);
      DM.clntdtstProprietarios.open;
      if DM.clntdtstProprietarios.RecordCount > 0 then
      begin
        edtDescricao.Text := DM.clntdtstProprietarios.FieldByName('nome').AsString;
      end
      else
      begin
        Application.MessageBox('Registro n�o encontrado.', 'Curral Novo', MB_OK);
        edtCodigo.SetFocus;
      end;
    end;
  end
  else
  begin
    frmPesquisa := TfrmPesquisa.Create(Self);
    try
      frmPesquisa.vTabela := 'VETERINARIO';
      frmPesquisa.vComando := 'Select ID, NOME from VETERINARIO';
      frmPesquisa.vTela := 'REL_INSEMINACAO';
      frmPesquisa.ShowModal;
    finally
      frmPesquisa.Release;
    end;
  end;
 end;
procedure TfrmRelInseminacoes.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If key = #13 then
  Begin
    Key:= #0;
    Perform(Wm_NextDlgCtl,0,0);
  end;
end;

procedure TfrmRelInseminacoes.edtCodigoKeyPress(Sender: TObject;
  var Key: Char);
begin
  If not( key in['0'..'9',#08] ) then
    key := #0;
end;

end.
