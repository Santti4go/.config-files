# python library with utilites
# @author: Santiago Aupi

from time import strftime, strptime, localtime

def UpcomingEventToday(date_event, input_fmt="%d %b - %H:%M"):
    _now = localtime()
    if type(date_event) == str:
        date_event = strptime(date_event, input_fmt)

    if  date_event.tm_mday == _now.tm_mday:
        if date_event.tm_hour > _now.tm_hour:
            return True
        elif date_event.tm_hour == _now.tm_hour and \
             date_event.tm_min >= _now.tm_min:
            return True
        else:
            return False
    else:
        return False


def GetEventDate(event, output_fmt_date, 
                input_fmt_date = "%Y-%m-%dT%H:%M:%S-03:00") -> str :
    start = event['start'].get('dateTime', event['start'].get('date'))
    return strftime(output_fmt_date, strptime(start, input_fmt_date))