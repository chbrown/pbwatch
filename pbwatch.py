#!/usr/bin/env python
import sys
import time
import logging
from ScriptingBridge import NSPasteboard, NSString, NSUTF8StringEncoding

pb = NSPasteboard.generalPasteboard()
logger = logging.Logger('pbwatch')
readable_types = ['public.utf8-plain-text']


def poll(last_changeCount, separator):
    current_changeCount = pb.changeCount()
    if current_changeCount != last_changeCount:
        # pb.types() will return a list of strings describing the available types currently on the pasteboard
        # show types available:
        available_types = pb.types()
        logging.debug('types: %s', ', '.join(available_types))
        # pb.availableTypeFromArray_(...) takes a list of strings and intersects it with the actually available types
        # pb.pasteboardItems() will return a list of NSPasteboardItem objects. Not sure what these are but Pasteboard-subsets.
        # pb.dataForType_(...) will return a single NSData object, if the specified type is available.
        data_type = pb.availableTypeFromArray_(readable_types)
        data = pb.dataForType_(data_type)
        if data is not None:
            string = NSString.alloc().initWithData_encoding_(data, NSUTF8StringEncoding)
            logger.info(string.encode('utf8'))
            if separator:
                logger.info(separator)
        else:
            logging.error('No supported types found.')
    return current_changeCount


def main():
    import argparse
    parser = argparse.ArgumentParser(description='Watch pasteboard, copying plaintext changes into a file or stdout')
    parser.add_argument('-f', '--filename', help='Append to file')
    parser.add_argument('--stdout', action='store_true', help='Output to stdout')
    parser.add_argument('-s', '--separator', help='Clibpoard contents separator')
    parser.add_argument('-i', '--interval', type=float, help='Polling interval', default=0.5)
    # e.g., use -s $'\n---\n' to put an empty line between each dump and --- separator
    opts = parser.parse_args()

    if opts.filename:
        # logging.FileHandler(filename, mode='a', encoding=None, delay=False)
        file_handler = logging.FileHandler(opts.filename)
        logger.addHandler(file_handler)

    if opts.stdout or not opts.filename:
        # logging.StreamHandler(stream=None)
        stream_handler = logging.StreamHandler(sys.stdout)
        logger.addHandler(stream_handler)

    last_changeCount = 0
    while True:
        last_changeCount = poll(last_changeCount, opts.separator)
        time.sleep(opts.interval)


if __name__ == '__main__':
    main()
