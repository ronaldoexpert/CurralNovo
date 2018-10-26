unit untCancelaInseminacao;       //Versao 1.5.0 - 25/10/2018 - RS

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmCancelaInseminacao = class(TForm)
    pnlPrincipal: TPanel;
    pnlRodape: TPanel;
    lblInseminacoes: TLabel;
    btnFechar: TBitBtn;
    grpTop: TGroupBox;
    edtCodProprietario: TEdit;
    lblProdutor: TLabel;
    btnPesquProprietario: TBitBtn;
    edtProprietario: TEdit;
    dbgInseminacoes: TDBGrid;
    btnPesquisar: TBitBtn;
    qryInseminacoes: TFDQuery;
    dtsInseminacoes: TDataSource;
    qryAuxiliar: TFDQuery;
    dtsAuxiliar: TDataSource;
    qryProdutor: TFDQuery;
    dtsProdutor: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodProprietarioChange(Sender: TObject);
    procedure edtCodProprietarioKeyPress(Sender: TObject; var Key: Char);
    procedure dbgInseminacoesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnPesquisarClick(Sender: TObject);
    procedure edtCodProprietarioExit(Sender: TObject);
    procedure btnPesquProprietarioClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
  private
    { Private declarations }
    procedure CarregaGrid;
  public
    { Public declarations }
    procedure PesquisaProdutor(vStatus : boolean);
  end;

var
  frmCancelaInseminacao: TfrmCancelaInseminacao;

implementation

{$R *.dfm}

uses untFuncoes, untPesquisa;

procedure TfrmCancelaInseminacao.btnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TfrmCancelaInseminacao.btnPesquisarClick(Sender: TObject);
begin
  if edtCodProprietario.Text <> '' then
    CarregaGrid
  else
    ShowMessage('Selecione um produto.');
  edtCodProprietario.SetFocus;
end;

procedure TfrmCancelaInseminacao.btnPesquProprietarioClick(Sender: TObject);
begin
  PesquisaProdutor(False);
end;

procedure TfrmCancelaInseminacao.CarregaGrid;
begin
  qryInseminacoes.Close;
  qryInseminacoes.SQL.Clear;
  qryInseminacoes.SQL.Add(frmFuncoes.LerArquivoIni('INSEMINACAO', 'CANCELAR'));
  qryInseminacoes.ParamByName('ID_PRODUTOR').AsString := edtCodProprietario.Text;
  qryInseminacoes.Open;

  dbgInseminacoes.Columns.Items[0].Visible := False;
  dbgInseminacoes.Columns.Items[1].Visible := False;
  lblInseminacoes.Caption := IntToStr(qryInseminacoes.RecordCount) + ' Inseminações';
end;

procedure TfrmCancelaInseminacao.dbgInseminacoesKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
VAR
  vIdInseminacao, vIdMovi : String;
begin
  if (Key = VK_DELETE) then
  begin
    if Application.MessageBox('Deseja realmente cancelar a Inseminação?', 'Curral Novo', MB_YESNO) = mrYes then
    begin
      vIdInseminacao := qryInseminacoes.FieldByName('IdInsem').AsString;
      vIdMovi := qryInseminacoes.FieldByName('IdMovi').AsString;
      frmFuncoes.ExecutaSQL('Update MOVI_INSEMINACAO set CONFIRMADA = ' + QuotedStr('A') + ', DATA_CONFIRMACAO = ' + QuotedStr('01/01/1900') + ' Where id = ' + vIdMovi, 'Executar', qryAuxiliar);
      frmFuncoes.ExecutaSQL('Update INSEMINACAO set FINALIZADA = ' + QuotedStr('N') + ', DT_FINALIZADA = ' + QuotedStr('01/01/1900') + ' Where id = ' + vIdInseminacao, 'Executar', qryAuxiliar);
      CarregaGrid;
    end;
  end;
end;

procedure TfrmCancelaInseminacao.edtCodProprietarioChange(Sender: TObject);
begin
  if Trim(edtCodProprietario.Text) = '' then
    edtProprietario.Clear;
end;

procedure TfrmCancelaInseminacao.edtCodProprietarioExit(Sender: TObject);
begin
  if edtCodProprietario.Text <> '' then
    PesquisaProdutor(True);
end;

procedure TfrmCancelaInseminacao.edtCodProprietarioKeyPress(Sender: TObject;
  var Key: Char);
begin
  If not( key in['0'..'9',#08] ) then
    key := #0;
end;

procedure TfrmCancelaInseminacao.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If key = #13 then
  Begin
    Key:= #0;
    Perform(Wm_NextDlgCtl,0,0);
  end;
end;

procedure TfrmCancelaInseminacao.FormShow(Sender: TObject);
begin
  edtCodProprietario.Clear;
  edtProprietario.Clear;
  qryInseminacoes.Close;
end;

procedure TfrmCancelaInseminacao.PesquisaProdutor(vStatus: boolean);
begin
  if vStatus = True then
  begin
    if Trim(edtCodProprietario.Text) <> '' then
    begin
      frmFuncoes.ExecutaSQL('Select * from PRODUTOR where ID =  ' + QuotedStr(edtCodProprietario.Text), 'Abrir', qryProdutor);
      if qryProdutor.RecordCount > 0 then
      begin
        edtProprietario.Text := qryProdutor.FieldByName('NOME').AsString;
      end
      else
      begin
        Application.MessageBox('Registro não encontrado.', 'Curral Novo', MB_OK);
      end;
    end;
  end
  else
  begin
    frmPesquisa := TfrmPesquisa.Create(Self);
    try
      frmPesquisa.vTabela := 'PRODUTOR';
      frmPesquisa.vTela := 'CANCELA_INS';
      frmPesquisa.vComando := frmFuncoes.LerArquivoIni('INSEMINACAO', 'PRODUTOR');
      frmPesquisa.ShowModal;
    finally
      frmPesquisa.Release;
    end;
  end;
end;

end.
