#!/usr/bin/python3

from __future__ import print_function

import datetime
from email.mime import base
import os.path

from google.auth.transport.requests import Request
from google.oauth2.credentials import Credentials
from google_auth_oauthlib.flow import InstalledAppFlow
from googleapiclient.discovery import build
from googleapiclient.errors import HttpError

# If modifying these scopes, delete the file token.json.
SCOPES = ['https://www.googleapis.com/auth/calendar.readonly']

base_path = '/home/santiago/.config/polybar/scripts/mycalendar/'
token_file = os.path.join(base_path, 'token.json')
credentials_file = os.path.join(base_path, 'credentials.json')

def query(N=10, log=False):
    """Shows basic usage of the Google Calendar API.
    Prints the start and name of the next 10 events on the user's calendar.
    """
    creds = None
    # The file token.json stores the user's access and refresh tokens, and is
    # created automatically when the authorization flow completes for the first
    # time.
    if os.path.exists(token_file):
        creds = Credentials.from_authorized_user_file(token_file, SCOPES)
    # If there are no (valid) credentials available, let the user log in.
    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            creds.refresh(Request())
        else:
            flow = InstalledAppFlow.from_client_secrets_file(
                    credentials_file, SCOPES)
            creds = flow.run_local_server(port=0)
        # Save the credentials for the next run
        with open('token.json', 'w') as token:
            token.write(creds.to_json())

    try:
        service = build('calendar', 'v3', credentials=creds)

        # Call the Calendar API
        now = datetime.datetime.utcnow().isoformat() + 'Z'  # 'Z' indicates UTC time
        # print('Getting the upcoming N events')
        events_result = service.events().list(calendarId='primary', timeMin=now,
                                              maxResults=N, singleEvents=True,
                                              orderBy='startTime').execute()
        events = events_result.get('items', [])

        if not events:
            print('No upcoming events found.')
            return

        # Prints the start and name of the next N events
        if log:
            for event in events:
                start = event['start'].get('dateTime', event['start'].get('date'))
                print(start, event['summary'])
        
        return events

    except HttpError as error:
        print('An error occurred: %s' % error)
        with open("debug.log", "w") as f:
            f.write(error)


if __name__ == '__main__':
    query()
    
