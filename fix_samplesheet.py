import argparse
import os


def fix_samplesheet(sample_sheet):
    old_ss = sample_sheet + '_old.csv'
    os.system('cp {} {}'.format(sample_sheet, old_ss))
    new_ss = ''
    change_line = False
    for line in open(sample_sheet):
        if change_line is True:
            line_list = line.split(',')
            line_list[0] = line_list[0].replace('.', '-')
            new_ss += ','.join(line_list)
        else:
            if line.startswith('Sample_ID,'):
                change_line = True
            new_ss += line
    out = open(sample_sheet, 'w')
    out.write(new_ss)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('-s', '--samplesheet', help='SampleSheet path')

    args = parser.parse_args()

    fix_samplesheet(sample_sheet=args.samplesheet)
