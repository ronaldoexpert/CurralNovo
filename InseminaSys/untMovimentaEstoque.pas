unit untMovimentaEstoque;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmMovimentaEstoque = class(TForm)
    edtCodProduto: TEdit;
    lblProduto: TLabel;
    edtDescrProduto: TEdit;
    btnAdd: TBitBtn;
    btnDelete: TBitBtn;
    dbgDados: TDBGrid;
    Panel1: TPanel;
    btnPesqProduto: TBitBtn;
    edtData: TMaskEdit;
    lblData: TLabel;
    edtQtd: TEdit;
    lblQuantidade: TLabel;
    pnlRodape: TPanel;
    btnNovo: TBitBtn;
    btnGravar: TBitBtn;
    btnCancelar: TBitBtn;
    btnFechar: TBitBtn;
    qryAuxiliar: TFDQuery;
    dtsAuxiliar: TDataSource;
    dtsGrid: TDataSource;
    qryGrid: TFDQuery;
    edtNumero: TEdit;
    lblNumero: TLabel;
    edtDescrAnimal: TEdit;
    btnPesqAnimal: TBitBtn;
    edtCodAnimal: TEdit;
    lblAnimal: TLabel;
    edtUnidade: TEdit;
    procedure btnNovoClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnPesqAnimalClick(Sender: TObject);
    procedure edtCodAnimalExit(Sender: TObject);
    procedure edtCodAnimalKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodAnimalKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAnimalChange(Sender: TObject);
    procedure btnPesqProdutoClick(Sender: TObject);
    procedure edtCodProdutoChange(Sender: TObject);
    procedure edtCodProdutoExit(Sender: TObject);
    procedure edtCodProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure dbgDadosDblClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    vEdita, fNovo : Boolean;               //Versao 1.1.0 - 25/05/2018
    function ValidaAnimal : Boolean;
  public
    { Public declarations }
    vTipoMovimento : String;      //Versao 1.6.1 - 20/11/2018
    procedure LimpaCampos;
    procedure CarregaGrid;
    procedure PesquisaProduto(vStatus : boolean);
    procedure PesquisaAnimal(vStatus : boolean);
  end;

var
  frmMovimentaEstoque: TfrmMovimentaEstoque;

implementation

{$R *.dfm}

uses untFuncoes, untPesquisa, untDM, untPrincipal;

procedure TfrmMovimentaEstoque.btnPesqAnimalClick(Sender: TObject);
begin
  PesquisaAnimal(False);
end;

procedure TfrmMovimentaEstoque.btnPesqProdutoClick(Sender: TObject);
begin
  PesquisaProduto(False);
end;

procedure TfrmMovimentaEstoque.btnAddClick(Sender: TObject);
begin
  if ValidaAnimal then
  begin
    if vEdita = False then
    begin
      qryGrid.Insert;
      qryGrid.FieldByName('ID').AsString := IntToStr(frmFuncoes.AutoIncre('MOVI_PRODUTO', 'Novo'));
    end
    else
    begin
      qryGrid.Edit;
    end;
    qryGrid.FieldByName('NUMERO').AsString := edtNumero.Text;
    qryGrid.FieldByName('ID_ANIMAL').AsString := edtCodAnimal.Text;
    qryGrid.FieldByName('NOME').AsString := edtDescrAnimal.Text;
    qryGrid.FieldByName('DATA').AsString := edtData.Text;
    qryGrid.FieldByName('ID_PRODUTO').AsString := edtCodProduto.Text;
    qryGrid.FieldByName('DESCRICAO').AsString := edtDescrProduto.Text;
    qryGrid.FieldByName('QUANTIDADE').AsString := edtQtd.Text;
    qryGrid.FieldByName('TIPO').AsString := vTipoMovimento;       //Versao 3.0.0 - 12/07/2022
    qryGrid.FieldByName('UNIDADE').AsString := 'UN';
    qryGrid.FieldByName('ALTERACAO').AsDateTime := Date+Time;
    qryGrid.FieldByName('USUARIO').AsInteger := frmPrincipal.vUsuario;
    qryGrid.Post;

    qryGrid.UpdateCursorPos;
    edtCodAnimal.Clear;
    edtDescrAnimal.Clear;
    edtCodAnimal.SetFocus;
    edtQtd.Text := '0';
  end;
end;

procedure TfrmMovimentaEstoque.btnCancelarClick(Sender: TObject);
begin
  LimpaCampos;
  Close;
end;

procedure TfrmMovimentaEstoque.btnDeleteClick(Sender: TObject);      //Versao 1.1.0 - 25/05/2018
begin
  qryGrid.Delete;
  edtCodAnimal.Clear;
  edtDescrAnimal.Clear;
  edtQtd.Text := '0';
  vEdita := False;
end;

procedure TfrmMovimentaEstoque.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMovimentaEstoque.btnGravarClick(Sender: TObject);
var
  vID : String;
begin
  qryGrid.First;
  while not qryGrid.Eof do
  begin
    vID := IntToStr(frmFuncoes.AutoIncre('MOVI_PRODUTO', 'Novo'));
    frmFuncoes.ExecutaSQL('Select * from MOVI_PRODUTO where id is null', 'Abrir', qryAuxiliar);
    qryAuxiliar.Insert;

    qryAuxiliar.FieldByName('ID').AsString := vID;
    qryAuxiliar.FieldByName('NUMERO').AsString := qryGrid.FieldByName('NUMERO').AsString;
    qryAuxiliar.FieldByName('DATA').AsString := qryGrid.FieldByName('DATA').AsString;
    qryAuxiliar.FieldByName('ID_PRODUTO').AsString := qryGrid.FieldByName('ID_PRODUTO').AsString;
    qryAuxiliar.FieldByName('ID_ANIMAL').AsString := qryGrid.FieldByName('ID_ANIMAL').AsString;
    qryAuxiliar.FieldByName('QUANTIDADE').AsString := qryGrid.FieldByName('QUANTIDADE').AsString;
    qryAuxiliar.FieldByName('TIPO').AsString := qryGrid.FieldByName('TIPO').AsString;
    qryAuxiliar.FieldByName('UNIDADE').AsString := qryGrid.FieldByName('UNIDADE').AsString;
    qryAuxiliar.FieldByName('ALTERACAO').AsDateTime := qryGrid.FieldByName('ALTERACAO').AsDateTime;
    qryAuxiliar.FieldByName('USUARIO').AsInteger := qryGrid.FieldByName('USUARIO').AsInteger;
    qryAuxiliar.FieldByName('CODEMPRESA').AsInteger := frmPrincipal.vEmpresa;        //Versao 1.4 - 14/10/2018

    qryAuxiliar.Post;
    qryAuxiliar.ApplyUpdates(-1);

    frmFuncoes.AutoIncre('MOVI_PRODUTO', '');
    qryGrid.Next;
  end;

  btnNovo.Enabled := True;        //Versao 1.1.0 - 25/05/2018
  btnGravar.Enabled := False;     //Versao 1.1.0 - 25/05/2018

  ShowMessage('Gravação efetuada com sucesso!');
end;

procedure TfrmMovimentaEstoque.btnNovoClick(Sender: TObject);
begin
  LimpaCampos;
  fNovo := True;
  vEdita := False;
  CarregaGrid;

  btnNovo.Enabled := False;
  btnGravar.Enabled := True;
  edtData.SetFocus;
  edtNumero.Text := frmFuncoes.FormataNumero(IntToStr(frmFuncoes.AutoIncre('MOVI_PRODUTO', 'Novo')));
  edtCodProduto.Text := dm.qryConfiguracao.FieldByName('produto_inseminacao').AsString;
  if edtCodProduto.Text <> '' then
    PesquisaProduto(True);
end;

procedure TfrmMovimentaEstoque.CarregaGrid;
begin
  frmFuncoes.ExecutaSQL('select MP.ID, MP.NUMERO, MP.DATA, MP.ID_ANIMAL, ' +
  ' A.NOME, MP.ID_PRODUTO, P.DESCRICAO, MP.QUANTIDADE, ' +
  ' MP.TIPO, MP.UNIDADE, MP.ALTERACAO, MP.USUARIO ' +
  ' FROM ANIMAL A join MOVI_PRODUTO MP on (A.ID = MP.ID_ANIMAL) JOIN PRODUTO P ON (P.ID = MP.ID_PRODUTO) WHERE MP.ID IS NULL', 'Abrir', qryGrid);

  dbgDados.Columns.Items[0].Visible := True;  //ID
  dbgDados.Columns.Items[1].Visible := False;  //NUMERO
  dbgDados.Columns.Items[2].Visible := False;  //DATA
  dbgDados.Columns.Items[3].Visible := False;  //ID_ANIMAL
  dbgDados.Columns.Items[4].Visible := True;  //ANIMAL
  dbgDados.Columns.Items[4].Width := 150;
  dbgDados.Columns.Items[5].Visible := False;  //ID_PRODUTO
  dbgDados.Columns.Items[6].Visible := True;  //PRODUTO
  dbgDados.Columns.Items[6].Width := 150;
  dbgDados.Columns.Items[7].Visible := True;  //QUANTIDADE
  dbgDados.Columns.Items[7].Width := 80;
  dbgDados.Columns.Items[8].Visible := False;  //TIPO
  dbgDados.Columns.Items[9].Visible := False;  //UNIDADE
  dbgDados.Columns.Items[10].Visible := False;  //ALTERACAO
  dbgDados.Columns.Items[11].Visible := False;  //USUARIO


  TFMTBCDField(qryGrid.FieldByName('QUANTIDADE')).DisplayFormat   := '###,####,###,##0.00';

  qryGrid.Insert;
end;

procedure TfrmMovimentaEstoque.dbgDadosDblClick(Sender: TObject);      //Versao 1.1.0 - 25/05/2018
begin
  vEdita := True;
  edtCodAnimal.Text := qryGrid.FieldByName('id_Animal').AsString;
  edtDescrAnimal.Text := qryGrid.FieldByName('nome').AsString;
  edtQtd.Text := qryGrid.FieldByName('quantidade').AsString;
end;

procedure TfrmMovimentaEstoque.edtCodAnimalChange(Sender: TObject);
begin
  if trim(edtCodAnimal.Text) = '' then
    edtDescrAnimal.Clear;
end;

procedure TfrmMovimentaEstoque.edtCodAnimalExit(Sender: TObject);
begin
  if trim(edtCodAnimal.Text) <> '' then
    PesquisaAnimal(True);
end;

procedure TfrmMovimentaEstoque.edtCodAnimalKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F2 then
    btnPesqAnimalClick(Self);
end;

procedure TfrmMovimentaEstoque.edtCodAnimalKeyPress(Sender: TObject;
  var Key: Char);
begin
  If not( key in['0'..'9',#08] ) then
    key := #0;
end;

procedure TfrmMovimentaEstoque.edtCodProdutoChange(Sender: TObject);
begin
  if trim(edtCodProduto.Text) = '' then
    edtDescrProduto.Clear;
end;

procedure TfrmMovimentaEstoque.edtCodProdutoExit(Sender: TObject);
begin
  if trim(edtCodProduto.Text) <> '' then
    PesquisaProduto(True);
end;

procedure TfrmMovimentaEstoque.edtCodProdutoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F2 then
    btnPesqProdutoClick(Self);
end;

procedure TfrmMovimentaEstoque.edtCodProdutoKeyPress(Sender: TObject;
  var Key: Char);
begin
  If not( key in['0'..'9',#08] ) then
    key := #0;
end;

procedure TfrmMovimentaEstoque.FormActivate(Sender: TObject);
begin
  LimpaCampos;
  CarregaGrid;
  edtNumero.SetFocus;
end;

procedure TfrmMovimentaEstoque.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If key = #13 then
  Begin
    Key:= #0;
    Perform(Wm_NextDlgCtl,0,0);
  end;
end;

procedure TfrmMovimentaEstoque.FormShow(Sender: TObject);
begin
  if vTipoMovimento = 'E' then
    Caption := Caption + 'Entrada'
  else
    Caption := Caption + 'Saída';
end;

procedure TfrmMovimentaEstoque.LimpaCampos;
begin
  edtNumero.Clear;
  edtData.Text := DateToStr(Date);
  edtCodProduto.Clear;
  edtDescrProduto.Clear;
  edtQtd.Text := '0';
end;

procedure TfrmMovimentaEstoque.PesquisaProduto(vStatus: boolean);
begin
  if vStatus = True then
  begin
    if Trim(edtCodProduto.Text) <> '' then
    begin
      frmFuncoes.ExecutaSQL('Select * from PRODUTO where ID = ' + QuotedStr(edtCodProduto.Text), 'Abrir', dm.qryProduto);
      if dm.qryProduto.RecordCount > 0 then
      begin
        edtDescrProduto.Text :=  dm.qryProduto.FieldByName('DESCRICAO').AsString;
        edtUnidade.Text := dm.qryProduto.FieldByName('UNIDADE').AsString;
      end
      else
      begin
        Application.MessageBox('Registro não encontrado.', 'Curral Novo', MB_OK);
        edtCodProduto.SetFocus;
      end;
    end;
  end
  else
  begin
    frmPesquisa := TfrmPesquisa.Create(Self);
    try
      frmPesquisa.vTabela := 'PRODUTO';
      frmPesquisa.vTela := 'MOVI_PRODUTO';
      frmPesquisa.vComando := frmFuncoes.LerArquivoIni('MOVIESTOQUE', 'PRODUTO_S');
      frmPesquisa.ShowModal;
    finally
      frmPesquisa.Release;
    end;
  end;
end;

function TfrmMovimentaEstoque.ValidaAnimal: Boolean;
var
  vRetorno : Boolean;
begin
  vRetorno := True;

  if edtCodProduto.Text = '' then
  begin
    ShowMessage('Insira o Produto!');
    edtCodProduto.SetFocus;
    vRetorno := False;
  end;

  if edtCodAnimal.Text = '' then
  begin
    ShowMessage('Insira o Animal!');
    edtCodAnimal.SetFocus;
    vRetorno := False;
  end;

  if Trim(edtQtd.Text) = '0' then
  begin
    ShowMessage('Insira a Quantidade!');
    edtQtd.SetFocus;
    vRetorno := False;
  end;

  Result := vRetorno;
end;

procedure TfrmMovimentaEstoque.PesquisaAnimal(vStatus: boolean);
begin
  if vStatus = True then
  begin
    if Trim(edtCodAnimal.Text) <> '' then
    begin
      frmFuncoes.ExecutaSQL('Select * from ANIMAL where SEXO = ' + QuotedStr('M') + ' and ID = ' + QuotedStr(edtCodAnimal.Text), 'Abrir', DM.qryAnimal);
      if DM.qryAnimal.RecordCount > 0 then
      begin
        edtDescrAnimal.Text := DM.qryAnimal.FieldByName('NOME').AsString;
      end
      else
      begin
        Application.MessageBox('Registro não encontrado.', 'Curral Novo', MB_OK);
        edtCodAnimal.SetFocus;
        edtCodAnimal.Clear;
        edtDescrAnimal.Clear;
      end;
    end;
  end
  else
  begin
    frmPesquisa := TfrmPesquisa.Create(Self);
    try
      frmPesquisa.vTabela := 'ANIMAL';
      frmPesquisa.vTela := 'MOVI_PRODUTO';
      frmPesquisa.vComando := frmFuncoes.LerArquivoIni('MOVIESTOQUE', 'ANIMAL');
      frmPesquisa.ShowModal;
    finally
      frmPesquisa.Release;
    end;
  end;
end;

end.

