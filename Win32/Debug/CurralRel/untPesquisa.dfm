object frmPesquisa: TfrmPesquisa
  Left = 398
  Top = 243
  Width = 583
  Height = 297
  Caption = 'Pesquisa'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnActivate = FormActivate
  OnKeyDown = edtPesquisaKeyDown
  OnKeyPress = edtPesquisaKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlPesquisa: TPanel
    Left = 0
    Top = 169
    Width = 567
    Height = 90
    Align = alBottom
    Color = clBtnHighlight
    TabOrder = 0
    object btnFechar: TBitBtn
      Left = 456
      Top = 41
      Width = 81
      Height = 37
      Caption = '&Fechar'
      TabOrder = 0
      OnClick = btnFecharClick
      Glyph.Data = {
        360C0000424D360C000000000000360000002800000020000000200000000100
        180000000000000C000000000000000000000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF6F43437243430B0707FF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FF9E6B6BA573737B49495D3737FF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFFD9D9C090909F6C6CA06D6D8A57577C49494A
        2A2A110909FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FF010101FFDBDBC394949F6C6C9F6C6CA16E6E9F6C6C7E
        4B4B774242241414010101FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF6060607878786D6D
        6D878887A7A8A8A3A6A59DA19FFFDADAC49696A16E6EA16E6EA16E6EA16E6EA0
        6D6DA16E6E9D6A6A895656703D3D512B2BFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF6868687878786E6E
        6E878185ABA3A9BFB8BDC5C3C7FFDADAC69797A26F6FA26F6FA26F6FA26F6FA1
        6E6EA16E6EA06D6DA26F6F915E5E7D4949121212FF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF6767677A7A7A7070
        702C9E4B21AF461FAD4517B242FFDADCC49A99A47171A47171A47171A47171A3
        7070A37070A26F6FA26F6FA16E6EA570703A3B3BFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF6A6A6A7F7F7F7171
        712A96441FA8401FA64018AB3FFFDBDDC69A99A57272A57272A57272A57272A4
        7171A47171A37070A37070A26F6FA67171393B3BFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FF008000006300FF00FF6868688282827272
        72228A3817973017963010992DFFDBDDC69C9CA87575A87575A77474A77474A7
        7474A67373A67373A57272A47171A672723C3D3DFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FF0080000C88150001006666668282827373
        73208230139029138F290B9226FFDBDDC99F9EA97676A97676A87575A97575A8
        7474A77474A77474A67373A57272A773733C3D3DFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FF007A0031B35811911C459B458484847575
        751578210C811A0C801A038116FFDCDEC9A0A0AB7878AB7878A77474A07070A4
        7373A67474A97676A87575A77474A975753D3F3FFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FF006F0033BA5B3CBD6A10941BB4B4B47777
        7712711A08781208781200780DFFDCDDCAA1A0AC7979AD7979986E6E9C6E6EA3
        7272A57474AB7777A97676A87575AA76763D3F3FFF00FFFF00FFFF00FF2FB55D
        2FB05A31B05B34B15E36B26037B16138B0623EC56D49E47D41C97010961952A9
        52055E03006200006100006200FFDBDCCCA4A4B18585AAACACABABABA0A2A2A1
        7171A67575AD7979AB7878AA7777AC7878404242FF00FFFF00FFFF00FF41D172
        37CA693ACF6C3DCF6E40D37140D37243D77545D6754CE57F4DE78041BD6D0F98
        189ED6C56BD3B46AD1B367D7B6FFDBDCCDA5A5BEA2A2C8CBCBD2D2D2C1C2C2A8
        7575AE7C7CAD7A7AAC7979AB7878AD7979424343FF00FFFF00FFFF00FF5ADE88
        3DD57140D97342DB7545DE7847E07A4AE37D4CE57F4FE88250E98353ED8748CB
        740E9C1669D27BB7FFFFB7FFFFFFDADAD1ABABBD9191DFE3E3E5E6E6CBCFCFB0
        7C7CB07D7DAF7C7CAE7B7BAD7A7AAD7979434545FF00FFFF00FFFF00FF5CDF89
        49D97941DA7443DC7647E07A49E27C4CE57F4EE78151EA8452EB8556EF8957F0
        8A48BE71109E19D7FFFFCCFFFFFFDADAD2AEAEB27D7DC49F9FBCB4B4B4A0A0B1
        7E7EB17E7EB07D7DAF7C7CAE7B7BAE7A7A434545FF00FFFF00FFFF00FF5FE28B
        62E08D44DD7746DF794AE37D4CE57F50E98351EA8455EE8856EF8959F28C5BF5
        8F0C9C1281D585EEFFFFF3FFFFFFDADAD4AFAFB58282B58282B58282B48181B3
        8080B38080B27F7FB17E7EB07D7DB17D7D454747FF00FFFF00FFFF00FF60E38E
        71E39747DF794AE17C4FE58151E78355EB8757ED8A57F08A58F18B5CF5905EF8
        9280D380FFFFFFFEFFFDFFFFFFFFDADAD4B0B0B68383B68383B68383B58282B4
        8181B48181B38080B27F7FB17E7EB07B7B464848FF00FFFF00FFFF00FF45DD78
        4BDD7C4FE17F53E48456E98858EB8A5AEE8C7AF3A259F38D5DF69114A91D5BAF
        5BFFF9F3FFF9F3FFF8F2FFFFF8FFDADAD6B3B3B98686B88585B88585B78484B6
        8383B68383B58282B48181B27F7FB27D7D484A4AFF00FFFF00FFFF00FF007400
        007500007A00007C00008100008300007C006BE58E5BF58F61FA975DB35DB0B0
        B0FFF6EDFFF6EDFFF5ECFFFCF2FFDADAD7B4B4BA8787BA8787B98686B98686B7
        8484B78484B68383B58282B38080B37E7E484949FF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FF00870060E88817AB234EA94E9D9D9D8484
        84FFF0E1FFF0E1FFEFE0FFF5E5FFDADAD8B6B6BC8989BC8888BB8888BB8888B9
        8686B98686B78484B78484B58282B47F7F494B4BFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FF00890055EB84007400B2B2B29D9D9D8686
        86FFEDDBFFEDDBFFECDAFFF1DEFFDADAD9B9B9BC8989D6A4A4C99595C18E8EB7
        8484B98686B88585B78484B78484B58181484949FF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FF009300007A00FF00FF828282A5A5A58888
        88FFE7CFFFE7CFFFE6CEFFEAD1FFDADADAB9B9BF8B8BE1B8B8FFE7E7FFE5E5FF
        E3E3FFE1E1FED5D5FACECEBA8787B68181484949FF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FF009100001800FF00FF838383A6A6A68A8A
        8AFFE4CAFFE4CAFFE3CAFFE7CCFFD9DADBBBBBC08C8CDCB6B6FFE9E9FFE8E8FF
        E3E3FFE0E0FFDBDBFFDADABA8686B78282484A4AFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF868686A8A8A88D8D
        8DFFDEBEFFDEBEFFDDBDFFDFBDFFD9D9DCBFBFC28E8ED5B3B3FFF2F2FFEEEEFF
        E7E7FFE3E3FFDDDDFFDBDBB78484B88383494B4BFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF878787A9A9A98E8E
        8EFFDBB8FFDBB8FFDAB7FFDDB6FFD9D9DDBEBEC49191C49E9EF8E9E9FFF1F1FF
        EFEFFFEBEBFFE1E1FFDFDFB88484B984844B4C4CFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF898989ABABAB9191
        91FFDAB0FFDAB0FFD9AEFFDAADFFDADADEC2C2C69393C59292C59292C49090C1
        8E8EBF8B8BBC8888B98585BA8787B884844C4E4EFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF8A8A8AB0B0B09292
        9298806A9C866FAE9379B4997CFFDADADEC1C1C69191C59191C49090C39090C1
        8E8EC08D8DBE8B8BBC8989BA8787BA8585494B4BFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF8D8D8DB3B3B39292
        929292929191918E8E8E8D8D8DB78E8EBC9090CA9797D09B9BDAA8A8E0B1B1E3
        B8B8DFB5B5DCAFAFDBACACD3A2A2C28C8C4A4B4BFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF8E8E8EBDBDBDA0A0
        A09999999696968F8F8F8C8C8C8689898387877F83837F8080847E7E867E7E8E
        7C7C907B7B987B7B9B7A7AA47C7C9E79794A4C4CFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9595958D8D8D8B8B
        8B8989898888888686868585858484848383838383838282828080808181817E
        7E7E7D7D7D7C7C7C7D7D7D787878767676474747FF00FFFF00FF}
    end
    object grp1: TGroupBox
      Left = 16
      Top = 6
      Width = 425
      Height = 75
      Caption = 'Pesquisa por'
      TabOrder = 1
      object lblCampoPesquisa: TLabel
        Left = 16
        Top = 22
        Width = 32
        Height = 13
        Caption = 'NOME'
      end
      object edtPesquisa: TEdit
        Left = 16
        Top = 41
        Width = 393
        Height = 21
        TabOrder = 0
        OnChange = edtPesquisaChange
        OnKeyDown = edtPesquisaKeyDown
        OnKeyPress = edtPesquisaKeyPress
      end
    end
  end
  object dbgrdPesquisa: TDBGrid
    Left = 0
    Top = 0
    Width = 567
    Height = 169
    Align = alClient
    DataSource = DM.dtsrcPesquisa
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = dbgrdPesquisaDblClick
    OnTitleClick = dbgrdPesquisaTitleClick
  end
end
