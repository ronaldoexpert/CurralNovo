unit untCadastroAnimal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Vcl.Buttons,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.ExtDlgs, JPEG, dateutils, UCrpeClasses, UCrpe32;

type
  TfrmCadastroAnimal = class(TForm)
    pnlRodape: TPanel;
    btnNovo: TBitBtn;
    btnGravar: TBitBtn;
    btnCancelar: TBitBtn;
    btnExcluir: TBitBtn;
    btnFechar: TBitBtn;
    pnlCentro: TPanel;
    lblCodigo: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    lblProprietario: TLabel;
    btnPesquisar: TBitBtn;
    edtCodigo: TEdit;
    edtNome: TDBEdit;
    edtIdentificacao: TDBEdit;
    rdgTipo: TRadioGroup;
    btnPesquProprietario: TBitBtn;
    edtCodProprietario: TEdit;
    edtProprietario: TDBEdit;
    PageControl1: TPageControl;
    tbResenha: TTabSheet;
    btnPesqFoto: TBitBtn;
    lblOutras: TLabel;
    qryAnimal: TFDQuery;
    dtsAnimal: TDataSource;
    qryProprietario: TFDQuery;
    dtsProprietario: TDataSource;
    OpenDialog1: TOpenDialog;
    chkSituacao: TDBCheckBox;
    btnLimpaFoto: TBitBtn;
    edtEstSemem: TDBEdit;
    lblEstoqueSemem: TLabel;
    OpenPictureDialog1: TOpenPictureDialog;
    imgAnimal: TImage;
    chkMorte: TCheckBox;
    edtDtMorte: TMaskEdit;
    tbGenealogia: TTabSheet;
    edtCodMae: TEdit;
    btnPesquisaMae: TBitBtn;
    edtNomeMae: TEdit;
    edtNomePai: TEdit;
    edtCodPai: TEdit;
    btnPesquisaPai: TBitBtn;
    imgFotoPai: TImage;
    imgFotoMae: TImage;
    edtCaminhoFoto: TEdit;
    edtNascimento: TDBEdit;
    lblDtNascimento: TLabel;
    edtObservacao: TDBMemo;
    btnImprimeCria: TBitBtn;
    lblIdadeCria: TLabel;
    Crpe1: TCrpe;
    lblMae: TLabel;
    lblPai: TLabel;
    grpImpressao: TRadioGroup;
    procedure btnFecharClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnPesquProprietarioClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure edtCodProprietarioExit(Sender: TObject);
    procedure edtCodigoExit(Sender: TObject);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodProprietarioKeyPress(Sender: TObject; var Key: Char);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnPesqFotoClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodigoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodProprietarioKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure rdgTipoClick(Sender: TObject);
    procedure btnLimpaFotoClick(Sender: TObject);
    procedure chkMorteClick(Sender: TObject);
    procedure edtCodMaeChange(Sender: TObject);
    procedure edtCodPaiChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisaMaeClick(Sender: TObject);
    procedure btnPesquisaPaiClick(Sender: TObject);
    procedure edtCodMaeExit(Sender: TObject);
    procedure edtCodPaiExit(Sender: TObject);
    procedure edtCodPaiKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMaeKeyPress(Sender: TObject; var Key: Char);
    procedure edtNascimentoExit(Sender: TObject);
    procedure btnImprimeCriaClick(Sender: TObject);
  private
    { Private declarations }
    vID : String;
    fNovo : Boolean;
    procedure LimpaCampos;
    function ValidaCampos : Boolean;
    procedure GravaFotoAnimal;      //Versao 1.6.0 - 09/11/2018 - RS
    function CalculaIdade(DataNasc: TDateTime) : String;      //Versao 1.6.0 - 09/11/2018 - RS
  public
    { Public declarations }
    vTipo : String;
    procedure PesquisaAnimal(vStatus : boolean);
    procedure PesquisaProprietario(vStatus : boolean);
    procedure CarregaCampos;
    procedure PesquisaMae(vStatus : boolean);      //Versao 1.6.0 - 09/11/2018 - RS
    procedure PesquisaPai(vStatus : boolean);      //Versao 1.6.0 - 09/11/2018 - RS
  end;

var
  frmCadastroAnimal: TfrmCadastroAnimal;

implementation

{$R *.dfm}

uses untDM, untPesquisa, untFuncoes, untPrincipal;

procedure TfrmCadastroAnimal.btnExcluirClick(Sender: TObject);
begin
  if fNovo = False then
  begin
    if qryAnimal.RecordCount > 0 then
    begin
      frmFuncoes.Botoes('Excluir', qryAnimal);
      LimpaCampos;
    end;
  end;
end;

procedure TfrmCadastroAnimal.btnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TfrmCadastroAnimal.btnGravarClick(Sender: TObject);
begin
  if ValidaCampos then
  begin
    if fNovo = True then
    begin
      qryAnimal.FieldByName('id').AsString := edtCodigo.Text;
    end;

    if rdgTipo.ItemIndex = 0 then
      qryAnimal.FieldByName('SEXO').AsString := 'F'
    else
      qryAnimal.FieldByName('SEXO').AsString := 'M';

    if chkMorte.Checked then                       //VERSAO 1.5 - 26/10/2018 - RS
      qryAnimal.FieldByName('morto').AsString := 'S'      //VERSAO 1.5 - 26/10/2018 - RS
    else
      qryAnimal.FieldByName('morto').AsString := 'N';      //VERSAO 1.5 - 26/10/2018 - RS

    if vTipo = 'Animal' then         //Versao 1.6.0 - 09/11/2018 - RS
      qryAnimal.FieldByName('TIPO').AsString := 'Animal'   //Versao 1.6.0 - 09/11/2018 - RS
    else
      qryAnimal.FieldByName('TIPO').AsString := 'Cria';    //Versao 1.6.0 - 09/11/2018 - RS

    qryAnimal.FieldByName('mae').AsString := edtCodMae.Text;        //Versao 1.6.0 - 09/11/2018 - RS
    qryAnimal.FieldByName('pai').AsString := edtCodPai.Text;        //Versao 1.6.0 - 09/11/2018 - RS
    qryAnimal.FieldByName('DT_MORTE').AsString := edtDtMorte.Text;      //VERSAO 1.5 - 26/10/2018 - RS
    qryAnimal.FieldByName('proprietario').AsString := edtCodProprietario.Text;
    qryAnimal.FieldByName('foto').AsString := edtCaminhoFoto.Text;
    qryAnimal.FieldByName('ALTERACAO').AsDateTime := Date + Time;
    qryAnimal.FieldByName('USUARIO').AsInteger := frmPrincipal.vUsuario;
    qryAnimal.FieldByName('CODEMPRESA').AsInteger := frmPrincipal.vEmpresa;        //Versao 1.4 - 14/10/2018

    qryAnimal.Post;
    qryAnimal.ApplyUpdates(-1);

    if edtCaminhoFoto.Text <> '' then
      GravaFotoAnimal;    //Versao 1.6.0 - 09/11/2018 - RS

    btnNovo.Enabled := True;
    btnExcluir.Enabled := True;
    edtCodigo.Enabled := True;
    fNovo := False;
    frmFuncoes.AutoIncre('ANIMAL', 'Gravar');
    ShowMessage('Cadastro realizado com sucesso.');
    PesquisaAnimal(True);    //Versao 1.3.0 - 19/07/2018 - RS
  end;
end;

procedure TfrmCadastroAnimal.btnImprimeCriaClick(Sender: TObject);
begin
  if edtCodigo.Text <> '' then
  begin
    Crpe1.DiscardSavedData;

    if grpImpressao.ItemIndex = 0 then  //Versao 1.6.4 - 19/03/2019 - RS
      Crpe1.ReportName := 'RelatorioS\Cria.rpt'
    else
      Crpe1.ReportName := 'RelatorioS\CriaP.rpt';    //Versao 1.6.4 - 19/03/2019 - RS
    Crpe1.ParamByName('CODIGO', '').CurrentValue := edtCodigo.Text;
    Crpe1.ParamByName('ID_ANIMAL', '').CurrentValue := edtCodMae.Text;

    Crpe1.Execute;
    Crpe1.SetFocus;
  end
  else
  begin
    ShowMessage('Selecione a Cria');
    edtCodigo.SetFocus;
  end;
end;

procedure TfrmCadastroAnimal.btnLimpaFotoClick(Sender: TObject);
begin
  edtCaminhoFoto.Text := 'fotos\imgPadrao.jpg';
  imgAnimal.picture.loadfromfile(edtCaminhoFoto.text);
end;

procedure TfrmCadastroAnimal.btnNovoClick(Sender: TObject);
begin
  LimpaCampos;
  fNovo := True;
  frmFuncoes.ExecutaSQL('Select * from ANIMAL where ID = ' + vID, 'Abrir', qryAnimal);
  CarregaCampos;
  qryAnimal.Insert;
  qryAnimal.FieldByName('situacao').AsString := 'Ativo';
  edtDtMorte.Text := '01/01/1900';

  btnNovo.Enabled := False;
  btnGravar.Enabled := True;
  btnExcluir.Enabled := False;
  edtNome.SetFocus;
  edtCodigo.Enabled := False;
  edtEstSemem.Field.Value := 0;

  edtCodigo.Text := IntToStr(frmFuncoes.AutoIncre('ANIMAL', 'Novo'));
end;

procedure TfrmCadastroAnimal.btnPesqFotoClick(Sender: TObject);
begin
  OpenDialog1.Filter := 'Arquivos JPG (*.JPG)|*.JPG';
  if OpenDialog1.Execute then
  begin
    edtCaminhoFoto.Text := OpenDialog1.FileName;
    If not fileexists (edtCaminhoFoto.text) then
      imgAnimal.picture := nil
    Else
      imgAnimal.picture.loadfromfile(edtCaminhoFoto.text);
  end;
end;

procedure TfrmCadastroAnimal.btnPesquisaMaeClick(Sender: TObject);
begin
  PesquisaMae(False);
end;

procedure TfrmCadastroAnimal.btnPesquisaPaiClick(Sender: TObject);
begin
  PesquisaPai(False)
end;

procedure TfrmCadastroAnimal.btnPesquisarClick(Sender: TObject);
begin
  if fNovo = False then
    PesquisaAnimal(False);
end;

procedure TfrmCadastroAnimal.btnPesquProprietarioClick(Sender: TObject);
begin
  PesquisaProprietario(False);
end;

function TfrmCadastroAnimal.CalculaIdade(DataNasc: TDateTime) : String;      //Versao 1.6.0 - 09/11/2018 - RS
Var
  CalcIdade       : Double;
  Ano, sA, sM, sD : String;
  A, M, D         : Word;
begin
   CalcIdade := ( Date - DataNasc);
   DecodeDate(CalcIdade,A,M,D);
   Dec(M);
   Ano := IntToStr(A);
   Delete(Ano,1,2);

   if A > 1 then
    sA := 'Anos'
  else
    sA := 'Ano';

  if M > 1 then
    sM := 'Meses'
  else
    sM := 'Mes';

  if D > 1 then
    sD := 'Dias'
  else
    sD := 'Dia';

  if Ano <> '00' then
    Result := Ano+' '+sA;
  if M > 0 then
    Result := Result + ' '+IntToStr(M)+' '+sM;
  if D > 0 then
    Result := Result + ' '+IntToStr(D)+' '+sD;
end;

procedure TfrmCadastroAnimal.CarregaCampos;
begin
  edtNome.DataField := 'NOME';
  edtIdentificacao.DataField := 'IDENTIFICACAO';
  chkSituacao.DataField := 'SITUACAO';
  edtEstSemem.DataField := 'ESTOQUE';
  edtNascimento.DataField := 'DATA_NASCIMENTO';
  edtObservacao.DataField := 'OBSERVACAO';

  qryAnimal.FieldByName('data_nascimento').EditMask := '00/00/0000';

  {COMENTADO >> //Versao 1.6.0 - 09/11/2018 - RS
  edtPelagem.DataField := 'PELAGEM';
  edtCabeca.DataField := 'CABECA';
  edtAD.DataField := 'AD';
  edtPD.DataField := 'PD';
  edtOutras.DataField := 'OUTRAS';
  edtAE.DataField := 'AE';
  edtPE.DataField := 'PE';}

  //chkMorte.DataField := 'MORTO';  //comentei > //VERSAO 1.5 - 26/10/2018 - RS   //Versao 1.4 - 14/10/2018
  //edtDtMorte.DataField := 'DT_MORTE';  //comentei > //VERSAO 1.5 - 26/10/2018 - RS   //Versao 1.4 - 14/10/2018
end;

procedure TfrmCadastroAnimal.chkMorteClick(Sender: TObject);     //Versao 1.4 - 14/10/2018
begin
  if chkMorte.Checked then            //Versao 1.4 - 14/10/2018
  begin
    edtDtMorte.Visible := True;
    edtDtMorte.Clear;
    edtDtMorte.SetFocus;
  end
  else
  begin
    edtDtMorte.Visible := False;
    edtDtMorte.Text := '01/01/1900';
  end;
end;

procedure TfrmCadastroAnimal.edtCodigoExit(Sender: TObject);
begin
  if Trim(edtCodigo.Text) <> '' then
    PesquisaAnimal(True);
end;

procedure TfrmCadastroAnimal.edtCodigoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F2 then
    btnPesquisarClick(Self);
end;

procedure TfrmCadastroAnimal.edtCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  If not( key in['0'..'9',#08] ) then
    key := #0;
end;

procedure TfrmCadastroAnimal.edtCodMaeChange(Sender: TObject);
begin
  if edtCodMae.Text = '' then
  begin
    imgFotoMae.picture.loadfromfile('fotos\imgPadrao.jpg');
    edtNomeMae.Clear;
  end;
end;

procedure TfrmCadastroAnimal.edtCodMaeExit(Sender: TObject);    //Versao 1.6.0 - 09/11/2018 - RS
begin
  if Trim(edtCodMae.Text) <> '' then
    PesquisaMae(True);
end;

procedure TfrmCadastroAnimal.edtCodMaeKeyPress(Sender: TObject; var Key: Char);
begin
  If not( key in['0'..'9',#08] ) then
    key := #0;
end;

procedure TfrmCadastroAnimal.edtCodPaiChange(Sender: TObject);    //Versao 1.6.0 - 09/11/2018 - RS
begin
  if edtCodPai.Text = '' then
  begin
    imgFotoPai.picture.loadfromfile('fotos\imgPadrao.jpg');
    edtNomePai.Clear;
  end;
end;

procedure TfrmCadastroAnimal.edtCodPaiExit(Sender: TObject);   //Versao 1.6.0 - 09/11/2018 - RS
begin
  if Trim(edtCodPai.Text) <> '' then
    PesquisaPai(True);
end;

procedure TfrmCadastroAnimal.edtCodPaiKeyPress(Sender: TObject; var Key: Char);
begin
  If not( key in['0'..'9',#08] ) then
    key := #0;
end;

procedure TfrmCadastroAnimal.edtCodProprietarioExit(Sender: TObject);    //Versao 1.6.0 - 09/11/2018 - RS
begin
  if Trim(edtCodProprietario.Text) <> '' then
    PesquisaProprietario(True);
end;

procedure TfrmCadastroAnimal.edtCodProprietarioKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F2 then
    btnPesquProprietarioClick(Self);
end;

procedure TfrmCadastroAnimal.edtCodProprietarioKeyPress(Sender: TObject;
  var Key: Char);
begin
  If not( key in['0'..'9',#08] ) then
    key:=#0;
end;

procedure TfrmCadastroAnimal.edtNascimentoExit(Sender: TObject);
begin
  if edtNascimento.Text <> '  /  /    ' then
    lblIdadeCria.Caption := 'Idade: ' + CalculaIdade(StrToDate(edtNascimento.Text))
end;

procedure TfrmCadastroAnimal.FormActivate(Sender: TObject);
begin
  LimpaCampos;
  frmFuncoes.ExecutaSQL('Select * from ANIMAL where ID = ' + vID, 'Abrir', qryAnimal);
  CarregaCampos;

  edtCodigo.SetFocus;
  imgAnimal.Picture.LoadFromFile('fotos/imgPadrao.jpg');
  imgFotoPai.Picture.LoadFromFile('fotos/imgPadrao.jpg');
  imgFotoMae.Picture.LoadFromFile('fotos/imgPadrao.jpg');
end;

procedure TfrmCadastroAnimal.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If key = #13 then
  Begin
    Key:= #0;
    Perform(Wm_NextDlgCtl,0,0);
  end;
end;

procedure TfrmCadastroAnimal.FormShow(Sender: TObject);
begin
  PageControl1.ActivePage := tbResenha;     //Versao 1.6.0 - 09/11/2018 - RS
  if vTipo = 'Cria' then                  //Versao 1.6.0 - 09/11/2018 - RS
  begin
    tbGenealogia.TabVisible := True;
    Caption := 'Cadastro de Cria';
    edtNascimento.Visible := True;
    lblDtNascimento.Visible := True;
    lblIdadeCria.Visible := True;
    btnImprimeCria.Visible := True;
    grpImpressao.Visible := True;       //VErsao 1.6.4 - 19/03/2019 - RS
  end
  else
  begin    //Versao 1.6.0 - 09/11/2018 - RS
    tbGenealogia.TabVisible := False;
    Caption := 'Cadastro de Animal';
    edtNascimento.Visible := False;
    lblDtNascimento.Visible := False;
    lblIdadeCria.Visible := False;
    btnImprimeCria.Visible := False;
    grpImpressao.Visible := False;      //VErsao 1.6.4 - 19/03/2019 - RS
  end;
end;

procedure TfrmCadastroAnimal.GravaFotoAnimal;       //Versao 1.6.0 - 09/11/2018 - RS
var
  vArquivo: TFileStream;
begin
  vArquivo := TFileStream.Create(edtCaminhoFoto.Text, fmOpenRead or fmShareDenyWrite);
  dm.qryAuxiliar.Close;
  dm.qryAuxiliar.SQL.Clear;
  dm.qryAuxiliar.SQL.Add('UPDATE ANIMAL SET FOTOANIMAL = :FOTOANIMAL WHERE ID = ' + edtCodigo.Text);
  dm.qryAuxiliar.Params[0].DataType := ftBlob;
  dm.qryAuxiliar.ParamByName('FOTOANIMAL').AsStream := vArquivo;
  dm.qryAuxiliar.ExecSQL;
  dm.qryAuxiliar.Close;
end;

procedure TfrmCadastroAnimal.LimpaCampos;
begin
  vID := '0';
  edtCodigo.Clear;
  edtNome.Clear;
  edtIdentificacao.Clear;
  edtProprietario.Clear;
  edtCodProprietario.Clear;
  edtEstSemem.Text := '0';
  rdgTipo.ItemIndex := 0;
  chkSituacao.Checked := True;
  edtObservacao.Clear;
  edtCaminhoFoto.Clear;
  imgAnimal.Picture.LoadFromFile('fotos/imgPadrao.jpg');        //Versao 1.6.0 - 09/11/2018 - RS
  imgFotoPai.Picture.LoadFromFile('fotos/imgPadrao.jpg');      //Versao 1.6.0 - 09/11/2018 - RS
  imgFotoMae.Picture.LoadFromFile('fotos/imgPadrao.jpg');     //Versao 1.6.0 - 09/11/2018 - RS
  edtNascimento.Clear;               //Versao 1.6.0 - 09/11/2018 - RS
end;

procedure TfrmCadastroAnimal.PesquisaAnimal(vStatus: boolean);
var
  vFoto   : TStream;
  vImagem : TJPEGImage;
begin
  if vStatus = True then
  begin
    if Trim(edtCodigo.Text) <> '' then
    begin
      qryAnimal.Close;
      qryAnimal.SQL.Clear;
      qryAnimal.SQL.Add('Select * from ANIMAL where ID = ' + QuotedStr(edtCodigo.Text) + ' and TIPO = ' + QuotedStr(vTipo));
      qryAnimal.Open;

      if qryAnimal.RecordCount > 0 then
      begin
        qryAnimal.Edit;
        CarregaCampos;

        edtCodProprietario.Text := qryAnimal.FieldByName('proprietario').AsString;
        if Trim(edtCodProprietario.Text) <> '' then
          PesquisaProprietario(True);

        if qryAnimal.FieldByName('SEXO').AsString = 'F' then
          rdgTipo.ItemIndex := 0
        else
          rdgTipo.ItemIndex := 1;

        if rdgTipo.ItemIndex = 0 then
        BEGIN
          edtEstSemem.Visible := False;
          lblEstoqueSemem.Visible := False;
        END
        else
        begin
          edtEstSemem.Visible := True;
          lblEstoqueSemem.Visible := True;
        end;

        if edtNascimento.Text <> '  /  /    ' then
          lblIdadeCria.Caption := 'Idade: ' + CalculaIdade(strtodate(edtNascimento.Text));      //Versao 1.6.0 - 09/11/2018 - RS

        //Lendo a imagem do campo BLOB para a Memória
        edtCaminhoFoto.Text := '';
        vFoto := qryAnimal.CreateBlobStream(qryAnimal.FieldByName('FOTOANIMAL'), bmRead);  //Versao 1.6.0 - 09/11/2018 - RS
        if vFoto.Size > 0 then
        begin
          vImagem := TJPEGImage.Create;             //Versao 1.6.0 - 09/11/2018 - RS
          vImagem.LoadFromStream(vFoto);           //Versao 1.6.0 - 09/11/2018 - RS
          imgAnimal.Picture.Assign(vImagem);       //Versao 1.6.0 - 09/11/2018 - RS
        end
        else
          imgAnimal.picture.loadfromfile('fotos/imgPadrao.jpg');


        if qryAnimal.FieldByName('MORTO').AsString = 'S' then  //VERSAO 1.5 - 26/10/2018 - RS
          chkMorte.Checked := True            //VERSAO 1.5 - 26/10/2018 - RS
        ELSE
          chkMorte.Checked := False;         //VERSAO 1.5 - 26/10/2018 - RS
        edtDtMorte.Text := qryAnimal.FieldByName('dt_MORTE').AsString;  //VERSAO 1.5 - 26/10/2018 - RS

        edtCodPai.Text := qryAnimal.FieldByName('PAI').AsString;
        if edtCodPai.Text <> '' then
          PesquisaPai(True);
        edtCodMae.Text := qryAnimal.FieldByName('MAE').AsString;
        if edtCodMae.Text <> '' then
          PesquisaMae(True);
      end
      else
      begin
        Application.MessageBox('Registro não encontrado.', 'Curral Novo', MB_OK);
        LimpaCampos;
      end;
    end;
  end
  else
  begin
    frmPesquisa := TfrmPesquisa.Create(Self);
    try
      frmPesquisa.vTabela := 'ANIMAL';
      frmPesquisa.vTela := 'CAD_ANIMAL';
      if vTipo = 'Animal' then     //Versao 1.6.0 - 09/11/2018 - RS
      BEGIN
        frmPesquisa.vComando := 'Select A.ID, A.NOME AS ANIMAL, A.IDENTIFICACAO, P.NOME AS PROPRIETARIO, A.TIPO from ANIMAL A JOIN PRODUTOR P ON (P.ID = A.PROPRIETARIO) Where A.SEXO = ' + QuotedStr('F') + ' and A.TIPO = ' + QuotedStr('Animal') + ' order by ANIMAL';
        frmPesquisa.vTela := 'CAD_ANIMAL';           //Versao 1.6.0 - 09/11/2018 - RS
      END
      else
      BEGIN
        frmPesquisa.vComando := 'Select A.ID, A.NOME AS ANIMAL, A.IDENTIFICACAO, P.NOME AS PROPRIETARIO, A.TIPO from ANIMAL A JOIN PRODUTOR P ON (P.ID = A.PROPRIETARIO) Where A.SEXO = ' + QuotedStr('F') + ' and A.TIPO = ' + QuotedStr('Cria') + ' order by ANIMAL';   //Versao 1.6.0 - 09/11/2018 - RS
        frmPesquisa.vTela := 'CAD_ANIMAL_CRIA';    //Versao 1.6.0 - 09/11/2018 - RS
      END;
      frmPesquisa.ShowModal;
    finally
      frmPesquisa.Release;
    end;
  end;
end;

procedure TfrmCadastroAnimal.PesquisaMae(vStatus: boolean);   //Versao 1.6.0 - 09/11/2018 - RS
var
  vFoto   : TStream;
  vImagem : TJPEGImage;
begin
  if vStatus = True then
  begin
    if Trim(edtCodMae.Text) <> '' then
    begin
      DM.qryMae.close;
      DM.qryMae.SQL.Clear;
      DM.qryMae.SQL.Add('Select * from ANIMAL where ID = ' + QuotedStr(edtCodMae.Text) + ' and SEXO = ' + QuotedStr('F'));
      DM.qryMae.Open;

      if DM.qryMae.RecordCount > 0 then
      begin
        {if FileExists(DM.qryMae.FieldByName('FOTO').AsString) then
          imgFotoMae.picture.loadfromfile(DM.qryMae.FieldByName('FOTO').AsString)
        else
          imgFotoMae.picture.loadfromfile('fotos/imgPadrao.jpg');}

        //Lendo a imagem do campo BLOB para a Memória
        vFoto := DM.qryMae.CreateBlobStream(DM.qryMae.FieldByName('FOTOANIMAL'), bmRead);  //Versao 1.6.0 - 09/11/2018 - RS
        if vFoto.Size > 0 then
        begin
          vImagem := TJPEGImage.Create;             //Versao 1.6.0 - 09/11/2018 - RS
          vImagem.LoadFromStream(vFoto);           //Versao 1.6.0 - 09/11/2018 - RS
          imgFotoMae.Picture.Assign(vImagem);       //Versao 1.6.0 - 09/11/2018 - RS
        end
        else
          imgFotoMae.picture.loadfromfile('fotos/imgPadrao.jpg');

        edtNomeMae.Text := DM.qryMae.FieldByName('NOME').AsString;
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
      frmPesquisa.vTabela := 'ANIMAL';
      frmPesquisa.vTela := 'CAD_CRIA_MAE';
      frmPesquisa.vComando := 'Select A.ID, A.NOME AS ANIMAL, A.IDENTIFICACAO, P.NOME AS PROPRIETARIO, A.TIPO from ANIMAL A JOIN PRODUTOR P ON (P.ID = A.PROPRIETARIO) where A.SEXO = ' + QuotedStr('F') + ' ORDER BY A.NOME';
      frmPesquisa.ShowModal;
    finally
      frmPesquisa.Release;
    end;
  end;
end;

procedure TfrmCadastroAnimal.PesquisaPai(vStatus: boolean);   //Versao 1.6.0 - 09/11/2018 - RS
var
  vFoto   : TStream;
  vImagem : TJPEGImage;
begin
  if vStatus = True then
  begin
    if Trim(edtCodPai.Text) <> '' then
    begin
      DM.qryMae.close;
      DM.qryMae.SQL.Clear;
      DM.qryMae.SQL.Add('Select * from ANIMAL where ID = ' + QuotedStr(edtCodPai.Text) + ' and SEXO = ' + QuotedStr('M'));
      DM.qryMae.Open;

      if DM.qryMae.RecordCount > 0 then
      begin
        {if FileExists(DM.qryMae.FieldByName('FOTO').AsString) then
          imgFotoPai.picture.loadfromfile(DM.qryMae.FieldByName('FOTO').AsString)
        else
          imgFotoPai.picture.loadfromfile('fotos/imgPadrao.jpg');}

        //Lendo a imagem do campo BLOB para a Memória
        vFoto := DM.qryMae.CreateBlobStream(DM.qryMae.FieldByName('FOTOANIMAL'), bmRead);  //Versao 1.6.0 - 09/11/2018 - RS
        if vFoto.Size > 0 then
        begin
          vImagem := TJPEGImage.Create;             //Versao 1.6.0 - 09/11/2018 - RS
          vImagem.LoadFromStream(vFoto);           //Versao 1.6.0 - 09/11/2018 - RS
          imgFotoPai.Picture.Assign(vImagem);       //Versao 1.6.0 - 09/11/2018 - RS
        end
        else
          imgFotoPai.picture.loadfromfile('fotos/imgPadrao.jpg');

        edtNomePai.Text := DM.qryMae.FieldByName('NOME').AsString;
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
      frmPesquisa.vTabela := 'ANIMAL';
      frmPesquisa.vTela := 'CAD_CRIA_PAI';
      frmPesquisa.vComando := 'Select A.ID, A.NOME AS ANIMAL, A.IDENTIFICACAO, P.NOME AS PROPRIETARIO, A.TIPO from ANIMAL A JOIN PRODUTOR P ON (P.ID = A.PROPRIETARIO) where A.SEXO = ' + QuotedStr('M') + ' ORDER BY A.NOME';
      frmPesquisa.ShowModal;
    finally
      frmPesquisa.Release;
    end;
  end;
end;

procedure TfrmCadastroAnimal.PesquisaProprietario(vStatus: boolean);
begin
  if vStatus = True then
  begin
    if Trim(edtCodigo.Text) <> '' then
    begin
      qryProprietario.Close;
      qryProprietario.SQL.Clear;
      qryProprietario.SQL.Add('Select * from PRODUTOR where ID = ' + QuotedStr(edtCodProprietario.Text));
      qryProprietario.Open;

      if qryProprietario.RecordCount > 0 then
      begin
        edtProprietario.DataField := 'NOME';
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
      frmPesquisa.vTela := 'CAD_ANIMAL';
      frmPesquisa.vComando := 'Select ID, NOME, INSC_RURAL from PRODUTOR';
      frmPesquisa.ShowModal;
    finally
      frmPesquisa.Release;
    end;
  end;
end;

procedure TfrmCadastroAnimal.rdgTipoClick(Sender: TObject);
begin
  if rdgTipo.ItemIndex = 0 then
  BEGIN
    edtEstSemem.Visible := False;
    lblEstoqueSemem.Visible := False;
  END
  else
  begin
    edtEstSemem.Visible := True;
    lblEstoqueSemem.Visible := True;
  end;
end;

function TfrmCadastroAnimal.ValidaCampos: Boolean;
var
  vRetorno : Boolean;
begin
  vRetorno := True;
  if trim(edtCodProprietario.Text) = '' then
  begin
    ShowMessage('Informe o proprietário!');
    edtCodProprietario.SetFocus;
    vRetorno := False;
  end
  else if trim(edtNome.Text) = '' then
  begin
    ShowMessage('Informe o nome do animal!');
    edtNome.SetFocus;
    vRetorno := False;
  end;

  if vTipo = 'Cria' then      //Versao 1.6.0 - 09/11/2018 - RS
  begin
    if trim(edtNascimento.Text) = '  /  /    ' then     //Versao 1.6.0 - 09/11/2018 - RS
    begin
      ShowMessage('Informe a data de nascimento!');
      edtNascimento.SetFocus;
      vRetorno := False;
    end
    else if trim(edtCodMae.Text) = '' then     //Versao 1.6.0 - 09/11/2018 - RS
    begin
      ShowMessage('Informe a Mãe da Cria!');
      PageControl1.TabIndex := 1;
      edtCodMae.SetFocus;
      vRetorno := False;
    end
    else if trim(edtCodMae.Text) = '' then     //Versao 1.6.0 - 09/11/2018 - RS
    begin
      ShowMessage('Informe o Pai da Cria!');
      PageControl1.TabIndex := 1;
      edtCodPai.SetFocus;
      vRetorno := False;
    end;
  end;

  Result := vRetorno;
end;

end.
