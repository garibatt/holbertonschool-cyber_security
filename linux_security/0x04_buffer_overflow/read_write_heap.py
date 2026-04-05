#!/usr/bin/python3
import sys
import re


def error():
    print("Usage: read_write_heap.py pid search_string replace_string")
    sys.exit(1)


def get_heap_region(pid):
    with open(f"/proc/{pid}/maps", "r") as maps:
        for line in maps:
            if "[heap]" in line:
                match = re.match(r"([0-9a-f]+)-([0-9a-f]+)", line)
                if match:
                    start = int(match.group(1), 16)
                    end = int(match.group(2), 16)
                    return start, end
    return None, None


def main():
    if len(sys.argv) != 4:
        error()

    pid = sys.argv[1]
    search = sys.argv[2].encode("ascii")
    replace = sys.argv[3].encode("ascii")

    if len(search) != len(replace):
        print("Error: search_string and replace_string must be the same length")
        sys.exit(1)

    try:
        start, end = get_heap_region(pid)
        if start is None:
            print("Error: Heap not found")
            sys.exit(1)

        print(f"[+] Heap region: {hex(start)} - {hex(end)}")

        with open(f"/proc/{pid}/mem", "rb+") as mem:
            mem.seek(start)
            heap = mem.read(end - start)

            index = heap.find(search)
            if index == -1:
                print("[-] String not found in heap")
                return

            print(f"[+] Found at offset: {hex(start + index)}")

            mem.seek(start + index)
            mem.write(replace)

            print("[+] Replacement successful")

    except PermissionError:
        print("Error: Permission denied (try running as root)")
        sys.exit(1)
    except FileNotFoundError:
        print("Error: Process not found")
        sys.exit(1)


if __name__ == "__main__":
    main()
