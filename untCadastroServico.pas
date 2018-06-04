unit untCadastroServico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.DBCtrls, Vcl.Mask, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmCadastroServico = class(TForm)
    pnlRodape: TPanel;
    btnNovo: TBitBtn;
    btnGravar: TBitBtn;
    btnCancelar: TBitBtn;
    btnExcluir: TBitBtn;
    btnFechar: TBitBtn;
    pnlCentro: TPanel;
    lblUsuario: TLabel;
    lblSenha: TLabel;
    lblCodigo: TLabel;
    btnPesquisar: TBitBtn;
    edtDescricao: TDBEdit;
    edtCodigo: TEdit;
    edtValorUnit: TDBEdit;
    chkSituacao: TDBCheckBox;
    procedure btnFecharClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodigoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    vID : String;
    fNovo : Boolean;
    procedure PesquisaBD(vStatus : boolean);
    procedure CarregaCampos;
  end;

var
  frmCadastroServico: TfrmCadastroServico;

implementation

{$R *.dfm}

uses untDM, untPesquisa, untFuncoes, untPrincipal;

procedure TfrmCadastroServico.btnCancelarClick(Sender: TObject);
begin
  if edtCodigo.Text <> '' then
  begin
    if fNovo = False then
    begin
      dm.qryServico.UndoLastChange(True);
      CarregaCampos;
    end
    else
    begin
      edtCodigo.Enabled := true;
      edtCodigo.Clear;
      CarregaCampos;
      btnNovo.Enabled := True;
      btnGravar.Enabled := True;
      btnExcluir.Enabled := True;
      fNovo := False;
    end;
  end;
end;

procedure TfrmCadastroServico.btnExcluirClick(Sender: TObject);
begin
  if fNovo = False then
  begin
    if DM.qryServico.RecordCount > 0 then
    begin
      frmFuncoes.Botoes('Excluir', DM.qryServico);
      edtCodigo.Clear;
      edtCodigo.SetFocus;
    end;
  end;
end;

procedure TfrmCadastroServico.btnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TfrmCadastroServico.btnGravarClick(Sender: TObject);
begin
  if fNovo = True then
  begin
    dm.qryServico.FieldByName('id').AsString := edtCodigo.Text;
  end;

  dm.qryServico.FieldByName('alteracao').AsDateTime := Date+time;
  dm.qryServico.FieldByName('usuario').AsInteger := frmPrincipal.vUsuario;

  btnNovo.Enabled := True;
  btnExcluir.Enabled := True;
  edtCodigo.Enabled := True;

  try
    frmFuncoes.Botoes('Gravar', dm.qryServico);
    frmFuncoes.AutoIncre('SERVICO', 'Gravar');
    PesquisaBD(True);
    fNovo := False;
  Except on E: Exception do
    ShowMessage('Erro na gravação. >>>> ' + E.Message);
  end;
end;

procedure TfrmCadastroServico.btnNovoClick(Sender: TObject);
begin
  fNovo := True;
  dm.qryServico.Insert;

  btnNovo.Enabled := False;
  btnGravar.Enabled := True;
  btnExcluir.Enabled := False;
  edtCodigo.Enabled := False;
  edtDescricao.SetFocus;
  chkSituacao.Checked := True;
  chkSituacao.Field.Value := 'Ativo';
  edtValorUnit.Field.Value := 0;

  edtCodigo.Text := IntToStr(frmFuncoes.AutoIncre('SERVICO', 'Novo'));
end;

procedure TfrmCadastroServico.btnPesquisarClick(Sender: TObject);
begin
  if fNovo = False then
    PesquisaBD(False);
  edtCodigo.SetFocus;
end;

procedure TfrmCadastroServico.CarregaCampos;
begin
  edtDescricao.DataField := 'DESCRICAO';
  edtValorUnit.DataField := 'VALOR';
  chkSituacao.DataField := 'SITUACAO';

  TFMTBCDField(dm.qryServico.FieldByName('valor')).DisplayFormat := '###,####,###,##0.00';
end;

procedure TfrmCadastroServico.edtCodigoExit(Sender: TObject);
begin
  if fNovo = False then
  begin
    if Trim(edtCodigo.Text) <> '' then
      PesquisaBD(True);
  end;
end;

procedure TfrmCadastroServico.edtCodigoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F2 then
    btnPesquisarClick(Self);
end;

procedure TfrmCadastroServico.edtCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  If not( key in['0'..'9',#08] ) then
    key := #0;
end;

procedure TfrmCadastroServico.FormActivate(Sender: TObject);
begin
  vID := '0';
  frmFuncoes.ExecutaSQL('Select * from SERVICO where ID = ' + vID, 'Abrir', DM.qryServico);
  CarregaCampos;
  edtCodigo.SetFocus;
end;

procedure TfrmCadastroServico.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If key = #13 then
  Begin
    Key:= #0;
    Perform(Wm_NextDlgCtl,0,0);
  end;
end;

procedure TfrmCadastroServico.PesquisaBD(vStatus: boolean);
begin
  if vStatus = True then
  begin
    if Trim(edtCodigo.Text) <> '' then
    begin
      frmFuncoes.ExecutaSQL('Select * from SERVICO where ID = ' + QuotedStr(edtCodigo.Text), 'Abrir', dm.qryServico);

      if dm.qryServico.RecordCount > 0 then
      begin
        dm.qryServico.Edit;
        CarregaCampos;
      end
      else
      begin
        Application.MessageBox('Registro não encontrado.', 'Curral Novo', MB_OK);
        edtCodigo.SetFocus;
      end;
    end;
  end
  else
  begin
    frmPesquisa := TfrmPesquisa.Create(Self);
    try
      frmPesquisa.vTabela := 'SERVICO';
      frmPesquisa.vComando := 'Select ID, DESCRICAO, VALOR from SERVICO';
      frmPesquisa.vTela := 'CAD_SERVICO';
      frmPesquisa.ShowModal;
    finally
      frmPesquisa.Release;
    end;
  end;
end;

end.
