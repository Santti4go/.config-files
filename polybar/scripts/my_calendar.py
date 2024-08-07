#!/usr/bin/python3

from time import strptime, strftime, localtime
from mycalendar.utilities import *
from mycalendar.calendar_api import query


CALENDAR_ICON = ""

origin_format_date = "%Y-%m-%dT%H:%M:%S-03:00"
desired_format_date = "%d %b - %H:%M"
meets = query(10)

def NoMeetingsToday():
    print("No meetings today :)")

def output_fmt(date):
    date = strptime(date, desired_format_date)
    return strftime("%H:%M", date)


def PrintEvent(event):
    global event_founded
    print(f"{CALENDAR_ICON} {output_fmt(event_date)}| {event['summary']}")
    event_founded = True

event_founded = False
first_unresponded_meet = None

for event in meets:
    my_response = None
    # loop all the attendes to get me
    attendees = event.get('attendees')
    if attendees:
        for attendee in attendees:
            if attendee.get('self'):
                my_response = attendee['responseStatus']
                break
    else: # I'm the only one on the event, print it
        if event["summary"] == "Home" or event["summary"] == "Office":
            continue
        event_date = GetEventDate(event, desired_format_date)
        if UpcomingEventToday(event_date):
            PrintEvent(event)
            event_founded = True
            break
    # verify if I'm going to attend the event
    if my_response == "declined":
        continue
    elif my_response == "accepted":
        if event['status'] == "confirmed":
            # Parse the date event with desired format
            event_date = GetEventDate(event, desired_format_date)
            if UpcomingEventToday(event_date):
                PrintEvent(event)
                event_founded = True
                break
    else:
        if not first_unresponded_meet:
            # Verify if I forgot to accept the first next meeting
            first_unresponded_meet = event

if not event_founded:
    if first_unresponded_meet == None:
        NoMeetingsToday()
    else:
    # Maybe I forgot to confirm the meeting so show it
        event = first_unresponded_meet
        event_date = GetEventDate(event, desired_format_date)
        # print it only if it's happening today
        if UpcomingEventToday(event_date, desired_format_date):
            PrintEvent(event)
        else:
            NoMeetingsToday()

