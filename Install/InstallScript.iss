; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{CBB90C23-2F68-4770-8469-85F0B78FFF25}
AppName=VBCorLib 3.0.0
AppVerName=VBCorLib 3.0.0
AppPublisher=Kelly Ethridge
AppPublisherURL=https://github.com/kellyethridge/VBCorLib
AppSupportURL=https://github.com/kellyethridge/VBCorLib
AppUpdatesURL=https://github.com/kellyethridge/VBCorLib
DefaultDirName={pf}\VBCorLib3
DefaultGroupName=VBCorLib
AllowNoIcons=yes
OutputDir=.
OutputBaseFilename=VBCorLib-3.0.0
Compression=lzma
SolidCompression=yes

[Languages]
Name: english; MessagesFile: compiler:Default.isl

[Types]
Name: "full"; Description: "Full installation"
Name: "custom"; Description: "Custom installation"; Flags: iscustom

[Components]
Name: "binaries"; Description: "Binary Files and Templates"; Types: full custom
Name: "examples"; Description: "Example Projects"; Types: full custom

[Files]
Source: ..\Binaries\Compiled\VBCorLib3.dll; DestDir: {sys}; Flags: regserver; Components: binaries
Source: ..\Examples\*; Excludes: "*.vbw,*.pdb,*.config"; DestDir: {app}\Examples; Flags: recursesubdirs; Components: examples
Source: ..\Source\CorLib\readme.txt; DestDir: {app}; Flags: isreadme
Source: LICENSE.txt; DestDir: {app};
Source: ..\Template\Classes\*; DestDir: {code:GetClassTemplatesFolder|{app}}; Components: binaries

[Icons]
Name: {group}\{cm:UninstallProgram,VBCorLib}; Filename: {uninstallexe}
Name: {group}\Examples; Filename: "{app}\Examples"; Components: examples;

[Code]
var
  TemplateDir: String;
  ProductDir: String;
  TemplateDirPage: TInputDirWizardPage;

function GetTemplatesFolder(): String;
begin
  RegQueryStringValue(HKCU,'Software\Microsoft\Visual Basic\6.0', 'TemplatesDirectory', TemplateDir);

  if TemplateDir = '' then
    begin
      RegQueryStringValue(HKLM,'Software\WOW6432Node\Microsoft\VisualStudio\6.0\Setup\Microsoft Visual Basic', 'ProductDir', ProductDir);
      TemplateDir := ProductDir + '\Templates\';
    end;
  Result := TemplateDir;
end;

procedure InitializeWizard;
begin
  TemplateDirPage := CreateInputDirPage(wpSelectDir,
    'Select Templates Directory', 'Select the Template folder location?',
    'Select the folder which contains Visual Basic template subfolders, then click Next.',
    False, '');
  
  TemplateDirPage.Add('');
  TemplateDirPage.Values[0] := GetTemplatesFolder();
end;

function GetClassTemplatesFolder(Param: string): String;
begin
  Result := TemplateDirPage.Values[0] + '\Classes\';
end;
