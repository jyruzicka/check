# Check.rb - simple checklists with ruby and prawn

Use this script to turn plaintext checklists into something a bit more special. Here's a sample checklist:

    Checklist title here:
    - This item is done! @done
    - This item isn't
    * You can use asterisks if you'd prefer

    This is a new group on the same checklist:
    * Here is another item

## Installation and use

Download and place somewhere safe. Symlink `check.rb` into your `$PATH`. Then, in terminal, run:

    check [--out=OUTPUT] file1.txt [file2...]

By default, this will turn `file1.txt` into a PDF called `file1.pdf`. If you specify a file using `--out`, it'll output to that file instead. If you specify a folder using `--out`, it'll output to `file1.pdf` in that folder.