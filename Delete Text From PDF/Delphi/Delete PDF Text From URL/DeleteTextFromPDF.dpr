program DeleteTextFromPDF;

//*******************************************************************************************//
//                                                                                           //
// Download Free Evaluation Version From: https://bytescout.com/download/web-installer       //
//                                                                                           //
// Also available as Web API! Get Your Free API Key: https://app.pdf.co/signup               //
//                                                                                           //
// Copyright � 2017-2020 ByteScout, Inc. All rights reserved.                                //
// https://www.bytescout.com                                                                 //
// https://pdf.co                                                                            //
//                                                                                           //
//*******************************************************************************************//

{$APPTYPE CONSOLE}

{$R *.res}

uses
    System.SysUtils,
    Classes,
    IdURI,
    ByteScoutWebApiExec in 'ByteScoutWebApiExec.pas';

const
    // The authentication key (API Key).
    // Get your own by registering at https://app.pdf.co
    API_KEY: string = '********************************************'
    // Direct URL of source PDF file.
	SOURCE_FILE_URL: string = 'https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-split/sample.pdf';
	// PDF document password. Leave empty for unprotected documents.
	PASSWORD: string = '';
	// Destination PDF file name
	DESTINATION_FILE: string = 'result.pdf';

var
    query: string;
    file_name: string;
    waiting_any_key: char;

begin
    try
        // Prepare URL for `Delete Text from PDF` API call
        query := TIdURI.URLEncode(Format('https://api.pdf.co/v1/pdf/edit/delete-text' +
            '?name=%s&password=%s&url=%s&searchString=conspicuous',
            [ExtractFileName(DESTINATION_FILE), PASSWORD, SOURCE_FILE_URL]));

        if (WebAPIExec(query, API_KEY, file_name)) then
            Writeln(Format('Generated PDF file saved as "%s" file.', [file_name]));
    finally
        Writeln('Press any key to continue...');
        Readln(waiting_any_key);
    end;
end.
