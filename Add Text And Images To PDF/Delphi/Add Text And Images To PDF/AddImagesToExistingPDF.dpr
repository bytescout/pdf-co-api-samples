program AddImagesToExistingPDF;

//*******************************************************************************************//
//                                                                                           //
// Download Free Evaluation Version From: https://bytescout.com/download/web-installer       //
//                                                                                           //
// Also available as Web API! Get Your Free API Key: https://app.pdf.co/signup               //
//                                                                                           //
// Copyright (c) 2017-2020 ByteScout, Inc. All rights reserved.                                //
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

var
    query: string;
    file_name: string;
    waiting_any_key: char;

const
    // The authentication key (API Key).
    // Get your own by registering at https://app.pdf.co/documentation/api
    API_KEY: string = '********************************************'
    // Direct URL of source PDF file.
    SOURCE_FILE_URL: string = 'https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-edit/sample.pdf';
    // Comma-separated list of page indices (or ranges) to process. Leave empty for all pages. Example: '0,2-5,7-'.
    PAGES: string = '';
    // PDF document password. Leave empty for unprotected documents.
    PASSWORD: string = '';

    // Destination PDF file name
    DESTINATION_FILE: string = 'result.pdf';

    // Image params
    TYPE1: string = 'image';
    X1: integer = 400;
    Y1: integer = 20;
    WIDTH1: integer = 119;
    HEIGHT1: integer = 32;
    IMAGE_URL: string = 'https://bytescout-com.s3.amazonaws.com/files/demo-files/cloud-api/pdf-edit/logo.png';

begin
    try
        // Prepare URL for `PDF Edit` API call
        query := TIdURI.URLEncode(Format('https://api.pdf.co/v1/pdf/edit/add' +
            '?name=%s&password=%s&pages=%s' +
            '&url=%s&type=%s&x=%d&y=%d&width=%d&height=%d&urlimage=%s',
            [ExtractFileName(DESTINATION_FILE), PASSWORD, PAGES,
            SOURCE_FILE_URL, TYPE1, X1, Y1, WIDTH1, HEIGHT1, IMAGE_URL]));

        if (WebAPIExec(query, API_KEY, file_name)) then
            Writeln(Format('Generated file saved to "%s" file."', [file_name]));
    finally
        Writeln('Press any key to continue...');
        Readln(waiting_any_key);
    end;
end.
